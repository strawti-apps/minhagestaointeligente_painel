import 'package:strawti_utils/strawti_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/material_model.dart';

class MaterialRepository extends StrautilsTryThis {
  static final _materialsTable = Supabase.instance.client.from('materials');

  FStrautilsResponse<List<MaterialModel>> getAllMaterials() {
    return tryThis(() async {
      final response = await _materialsTable.select().order('createdAt', ascending: false);
      final list = (response as List).map((json) => MaterialModel.fromMap(json)).toList();
      return StrautilsResponse.success(list);
    });
  }

  FStrautilsResponse<MaterialModel> createMaterial(MaterialModel material) {
    return tryThis(() async {
      final response = await _materialsTable.insert(material.toMap()).select().single();
      return StrautilsResponse.success(MaterialModel.fromMap(response));
    });
  }

  FStrautilsResponse<MaterialModel> updateMaterial(MaterialModel material) {
    return tryThis(() async {
      if (material.id == null) {
        return StrautilsResponse.warning('ID do material não fornecido para atualização');
      }
      final response = await _materialsTable.update(material.toMap()).eq('id', material.id!).select().single();
      return StrautilsResponse.success(MaterialModel.fromMap(response));
    });
  }

  FStrautilsResponse<bool> deleteMaterial(int materialId) {
    return tryThis(() async {
      await _materialsTable.delete().eq('id', materialId);
      return StrautilsResponse.success(true);
    });
  }
} 