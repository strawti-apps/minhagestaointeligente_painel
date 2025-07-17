import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/material_model.dart';
import '../../infra/repositories/material_repository.dart';
import '../../infra/services/storage_service.dart';
import '../../shared/mixins/loader_manager.dart';
import '../../shared/utils/app_snackbar.dart';

class MaterialsController extends GetxController with LoaderManager {
  final _materialRepository = MaterialRepository();

  final materialTitleController = TextEditingController();
  final materialFileUrlController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMaterials();
  }

  @override
  void onClose() {
    searchController.dispose();
    materialTitleController.dispose();
    materialFileUrlController.dispose();
    super.onClose();
  }

  String selectedSubModule = 'list';
  var materials = <MaterialModel>[];

  bool isSearchMode = false;
  final TextEditingController searchController = TextEditingController();
  var filteredMaterials = <MaterialModel>[];

  MaterialModel? materialToEdit;
  File? selectedFile;
  bool isUploadingFile = false;

  bool get isInListMode => selectedSubModule == 'list';

  Future<void> loadMaterials() async {
    changeLoading(true);

    final response = await _materialRepository.getAllMaterials();

    if (response.success && response.data != null) {
      materials = response.data!;
      filteredMaterials = List.from(materials);
    } else {
      materials = [];
      filteredMaterials = [];

      AppSnackbar.to.success(response.message);
    }

    changeLoading(false);
  }

  // Upload do arquivo - será chamado via widget
  Future<String?> uploadFile(File file) async {
    try {
      isUploadingFile = true;
      update();

      final response = await StorageService.uploadFile(
        file,
        bucketId: 'materials',
        folder: 'documents',
      );

      if (response.success && response.data != null) {
        AppSnackbar.to.success('Arquivo enviado com sucesso!', success: true);
        materialFileUrlController.text = response.data!;
        return response.data;
      } else {
        AppSnackbar.to.success('Erro ao fazer upload do arquivo: ${response.message}');
        return null;
      }
    } catch (e) {
      AppSnackbar.to.success('Erro inesperado no upload: $e');
      return null;
    } finally {
      isUploadingFile = false;
      update();
    }
  }

  // Upload usando bytes (para web)
  Future<String?> uploadFileBytes(Uint8List fileBytes, String fileName) async {
    try {
      isUploadingFile = true;
      update();

      final response = await StorageService.uploadBytes(
        fileBytes,
        fileName: fileName,
        bucketId: 'materials',
        folder: 'documents',
      );

      if (response.success && response.data != null) {
        AppSnackbar.to.success('Arquivo enviado com sucesso!', success: true);
        materialFileUrlController.text = response.data!;
        return response.data;
      } else {
        AppSnackbar.to.success('Erro ao fazer upload do arquivo: ${response.message}');
        return null;
      }
    } catch (e) {
      AppSnackbar.to.success('Erro inesperado no upload: $e');
      return null;
    } finally {
      isUploadingFile = false;
      update();
    }
  }

  Future<void> createMaterial() async {
    changeLoadingCreating(true);

    try {
      final newMaterial = MaterialModel(
        title: materialTitleController.text.trim(),
        fileUrl: materialFileUrlController.text.trim(),
        createdAt: DateTime.now(),
      );

      final response = await _materialRepository.createMaterial(newMaterial);

      if (response.success && response.data != null) {
        final createdMaterial = response.data!;

        // Adiciona à lista local
        materials.add(createdMaterial);
        filteredMaterials.add(createdMaterial);

        AppSnackbar.to.success('Material criado com sucesso', success: true);
        backToList();
      } else {
        AppSnackbar.to.success('Erro ao criar material');
      }
    } catch (e) {
      AppSnackbar.to.success('Erro ao criar material: $e');
    } finally {
      changeLoadingCreating(false);
    }
  }

  Future<void> updateMaterial() async {
    if (materialToEdit == null) return;

    changeLoadingEditing(true);

    try {
      final updatedMaterial = materialToEdit!.copyWith(
        title: materialTitleController.text.trim(),
        fileUrl: materialFileUrlController.text.trim(),
      );

      final response = await _materialRepository.updateMaterial(updatedMaterial);

      if (response.success && response.data != null) {
        final updatedMaterialResult = response.data!;

        // Atualiza na lista principal
        final mainIndex = materials.indexWhere(
          (material) => material.id == updatedMaterialResult.id,
        );
        if (mainIndex != -1) {
          materials[mainIndex] = updatedMaterialResult;
        }

        // Atualiza na lista filtrada
        final filteredIndex = filteredMaterials.indexWhere(
          (material) => material.id == updatedMaterialResult.id,
        );
        if (filteredIndex != -1) {
          filteredMaterials[filteredIndex] = updatedMaterialResult;
        }

        AppSnackbar.to.success('Material atualizado com sucesso', success: true);
        backToList();
      } else {
        AppSnackbar.to.success('Erro ao atualizar material');
      }
    } catch (e) {
      AppSnackbar.to.success('Erro ao atualizar material: $e');
    } finally {
      changeLoadingEditing(false);
    }
  }

  Future<void> goToDeleteItem(MaterialModel material) async {
    if (material.id == null) return;

    changeLoadingDeleting(true);

    final response = await _materialRepository.deleteMaterial(material.id!);

    if (response.success) {
      materials.removeWhere((m) => m.id == material.id);
      filteredMaterials.removeWhere((m) => m.id == material.id);

      AppSnackbar.to.success('Material excluído com sucesso', success: true);
    } else {
      AppSnackbar.to.success('Erro ao excluir material: ${response.message}');
    }

    changeLoadingDeleting(false);
  }

  void showDeleteMaterialConfirmation(MaterialModel material) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
          'Tem certeza que deseja excluir o material "${material.title}"?\n\nEsta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              goToDeleteItem(material);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  // Métodos de pesquisa
  void toggleSearchMode() {
    isSearchMode = !isSearchMode;
    if (!isSearchMode) {
      searchController.clear();
      filteredMaterials = List.from(materials);
    }
    update();
  }

  void searchMaterials(String query) {
    if (query.isEmpty) {
      filteredMaterials = List.from(materials);
    } else {
      final lowercaseQuery = query.toLowerCase();
      filteredMaterials = materials
          .where((material) => _materialMatchesQuery(material, lowercaseQuery))
          .toList();
    }
    update();
  }

  // Verifica se um material corresponde à consulta de pesquisa
  bool _materialMatchesQuery(MaterialModel material, String lowercaseQuery) {
    return _fieldContainsQuery(material.title, lowercaseQuery) ||
        _fieldContainsQuery(material.fileUrl, lowercaseQuery);
  }

  // Verifica se um campo (nullable) contém a query
  bool _fieldContainsQuery(String? field, String lowercaseQuery) {
    return field?.toLowerCase().contains(lowercaseQuery) ?? false;
  }

  // Navegar para criar novo material
  void goToCreateMaterial() {
    selectedSubModule = 'create_material';
    materialToEdit = null;
    clearMaterialForm();
    update();
  }

  // Navegar para editar material
  void goToEditItem(MaterialModel material) {
    selectedSubModule = 'edit_material';
    materialToEdit = material;
    loadMaterialDataToForm(material);
    update();
  }

  // Voltar para a lista
  void backToList() {
    selectedSubModule = 'list';
    materialToEdit = null;
    clearMaterialForm();
    update();
  }

  // Carregar dados do material no formulário
  void loadMaterialDataToForm(MaterialModel material) {
    materialTitleController.text = material.title;
    materialFileUrlController.text = material.fileUrl;
  }

  // Limpar formulário
  void clearMaterialForm() {
    materialTitleController.clear();
    materialFileUrlController.clear();
  }

  // Validar formulário
  bool validateMaterialForm() {
    if (materialTitleController.text.trim().isEmpty) {
      AppSnackbar.to.success('O título é obrigatório');
      return false;
    }

    if (materialFileUrlController.text.trim().isEmpty) {
      AppSnackbar.to.success('A URL do arquivo é obrigatória');
      return false;
    }

    return true;
  }

  // Salvar material (criar ou editar)
  Future<void> saveMaterial() async {
    if (!validateMaterialForm()) return;

    if (materialToEdit != null) {
      await updateMaterial();
    } else {
      await createMaterial();
    }
  }

  // Abrir arquivo no navegador
  void openFile(String fileUrl) {
    // TODO: Implementar abertura do arquivo
    AppSnackbar.to.success('Abrindo arquivo...');
  }
} 