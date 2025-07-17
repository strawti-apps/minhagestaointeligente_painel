import 'package:strawti_utils/strawti_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/module_model.dart';

class ModuleRepository extends StrautilsTryThis {
  static final _modulesTable = Supabase.instance.client.from('content_modules');
  
  // Obter um módulo pelo ID
  FStrautilsResponse<ModuleModel?> getModuleById(int id) {
    return tryThis(() async {
      final response = await _modulesTable.select().eq('id', id).maybeSingle();
      if (response == null) {
        return StrautilsResponse.warning('Módulo não encontrado');
      }
      return StrautilsResponse.success(ModuleModel.fromMap(response));
    });
  }
  
  // Obter todos os módulos
  FStrautilsResponse<List<ModuleModel>> getAllModules() {
    return tryThis(() async {
      final response = await _modulesTable.select().order('orderIndex', ascending: true);
      final list = (response as List).map((json) => ModuleModel.fromMap(json)).toList();
      return StrautilsResponse.success(list);
    });
  }
  
  // Obter módulos pelo ID do curso
  FStrautilsResponse<List<ModuleModel>> getModulesByCourseId(int courseId) {
    return tryThis(() async {
      final response = await _modulesTable.select().eq('courseId', courseId).order('orderIndex', ascending: true);
      final list = (response as List).map((json) => ModuleModel.fromMap(json)).toList();
      return StrautilsResponse.success(list);
    });
  }
  
  // Criar módulo
  FStrautilsResponse<ModuleModel> createModule(ModuleModel module) {
    return tryThis(() async {
      final response = await _modulesTable.insert(module.toMap()).select().single();
      return StrautilsResponse.success(ModuleModel.fromMap(response));
    });
  }
  
  // Atualizar módulo
  FStrautilsResponse<ModuleModel> updateModule(ModuleModel module) {
    return tryThis(() async {
      if (module.id == null) {
        return StrautilsResponse.warning('ID do módulo não fornecido para atualização');
      }
      final response = await _modulesTable.update(module.toMap()).eq('id', module.id!).select().single();
      return StrautilsResponse.success(ModuleModel.fromMap(response));
    });
  }
  
  // Deletar módulo
  FStrautilsResponse<bool> deleteModule(int id) {
    return tryThis(() async {
      await _modulesTable.delete().eq('id', id);
      return StrautilsResponse.success(true);
    });
  }
  
  // Atualizar ordem dos módulos
  FStrautilsResponse<bool> updateModuleOrder(List<ModuleModel> modules) {
    return tryThis(() async {
      final updates = modules.map((module) => {
        'id': module.id,
        'orderIndex': module.orderIndex,
      }).toList();
      await _modulesTable.upsert(updates);
      return StrautilsResponse.success(true);
    });
  }
} 