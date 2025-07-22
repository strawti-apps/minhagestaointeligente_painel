import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicoModel {
  final int id;
  final String nome;
  final String especialidade;
  final String crm;
  MedicoModel({
    required this.id,
    required this.nome,
    required this.especialidade,
    required this.crm,
  });
}

class PlantaoModel {
  final int id;
  final String medicoNome;
  final String data;
  final String horario;
  PlantaoModel({
    required this.id,
    required this.medicoNome,
    required this.data,
    required this.horario,
  });
}

class HospitalModel {
  final int id;
  final String nome;
  final String endereco;
  HospitalModel({required this.id, required this.nome, required this.endereco});
}

class SaudeController extends GetxController {
  // Médicos
  List<MedicoModel> medicos = [
    MedicoModel(
      id: 1,
      nome: 'Dra. Ana Silva',
      especialidade: 'Cardiologia',
      crm: '12345',
    ),
    MedicoModel(
      id: 2,
      nome: 'Dr. João Souza',
      especialidade: 'Pediatria',
      crm: '67890',
    ),
  ];
  List<MedicoModel> filteredMedicos = [];
  MedicoModel? medicoToEdit;
  final TextEditingController medicoNomeController = TextEditingController();
  final TextEditingController medicoEspecialidadeController =
      TextEditingController();
  final TextEditingController medicoCrmController = TextEditingController();
  final TextEditingController medicoSearchController = TextEditingController();

  // Plantões
  List<PlantaoModel> plantoes = [
    PlantaoModel(
      id: 1,
      medicoNome: 'Dra. Ana Silva',
      data: '2024-06-01',
      horario: '08:00-18:00',
    ),
    PlantaoModel(
      id: 2,
      medicoNome: 'Dr. João Souza',
      data: '2024-06-02',
      horario: '18:00-06:00',
    ),
  ];
  List<PlantaoModel> filteredPlantoes = [];
  PlantaoModel? plantaoToEdit;
  final TextEditingController plantaoMedicoNomeController =
      TextEditingController();
  final TextEditingController plantaoDataController = TextEditingController();
  final TextEditingController plantaoHorarioController =
      TextEditingController();
  final TextEditingController plantaoHorarioInicioController =
      TextEditingController();
  final TextEditingController plantaoHorarioFimController =
      TextEditingController();
  final TextEditingController plantaoSearchController = TextEditingController();

  bool isSearchModePlantoes = false;

  String selectedSubModule =
      'medicos_list'; // 'medicos_list', 'medico_create', 'medico_edit', 'plantoes_list', 'plantao_create', 'plantao_edit'

  HospitalModel? hospitalToEdit;
  final TextEditingController hospitalNomeController = TextEditingController();
  final TextEditingController hospitalEnderecoController =
      TextEditingController();
  List<HospitalModel> hospitais = [
    HospitalModel(
      id: 1,
      nome: 'Hospital Municipal',
      endereco: 'Rua Central, 100',
    ),
    HospitalModel(
      id: 2,
      nome: 'Hospital Regional',
      endereco: 'Av. Brasil, 200',
    ),
    HospitalModel(
      id: 3,
      nome: 'Hospital Santa Luzia',
      endereco: 'Rua das Flores, 300',
    ),
    HospitalModel(
      id: 4,
      nome: 'Hospital Vida Nova',
      endereco: 'Av. das Nações, 400',
    ),
  ];
  List<HospitalModel> filteredHospitais = [];

  @override
  void onInit() {
    super.onInit();
    filteredMedicos = List.from(medicos);
    filteredPlantoes = List.from(plantoes);
    filteredHospitais = List.from(hospitais);
  }

  // CRUD Médicos
  void goToCreateMedico() {
    selectedSubModule = 'medico_create';
    medicoToEdit = null;
    medicoNomeController.clear();
    medicoEspecialidadeController.clear();
    medicoCrmController.clear();
    update();
  }

  void goToEditMedico(MedicoModel medico) {
    selectedSubModule = 'medico_edit';
    medicoToEdit = medico;
    medicoNomeController.text = medico.nome;
    medicoEspecialidadeController.text = medico.especialidade;
    medicoCrmController.text = medico.crm;
    update();
  }

  void backToMedicosList() {
    selectedSubModule = 'medicos_list';
    medicoToEdit = null;
    medicoNomeController.clear();
    medicoEspecialidadeController.clear();
    medicoCrmController.clear();
    update();
  }

  void createMedico() {
    final novo = MedicoModel(
      id: medicos.isNotEmpty ? medicos.last.id + 1 : 1,
      nome: medicoNomeController.text,
      especialidade: medicoEspecialidadeController.text,
      crm: medicoCrmController.text,
    );
    medicos.add(novo);
    filteredMedicos.add(novo);
    backToMedicosList();
  }

  void updateMedico() {
    if (medicoToEdit == null) return;
    final index = medicos.indexWhere((m) => m.id == medicoToEdit!.id);
    if (index != -1) {
      medicos[index] = MedicoModel(
        id: medicoToEdit!.id,
        nome: medicoNomeController.text,
        especialidade: medicoEspecialidadeController.text,
        crm: medicoCrmController.text,
      );
      filteredMedicos = List.from(medicos);
    }
    backToMedicosList();
  }

  void deleteMedico(MedicoModel medico) {
    medicos.removeWhere((m) => m.id == medico.id);
    filteredMedicos.removeWhere((m) => m.id == medico.id);
    backToMedicosList();
  }

  void searchMedicos(String query) {
    if (query.isEmpty) {
      filteredMedicos = List.from(medicos);
    } else {
      filteredMedicos =
          medicos
              .where((m) => m.nome.toLowerCase().contains(query.toLowerCase()))
              .toList();
    }
    update();
  }

  // CRUD Plantões
  void goToCreatePlantao() {
    selectedSubModule = 'plantao_create';
    plantaoToEdit = null;
    plantaoMedicoNomeController.clear();
    plantaoDataController.clear();
    plantaoHorarioInicioController.clear();
    plantaoHorarioFimController.clear();
    update();
  }

  void goToEditPlantao(PlantaoModel plantao) {
    selectedSubModule = 'plantao_edit';
    plantaoToEdit = plantao;
    plantaoMedicoNomeController.text = plantao.medicoNome;
    plantaoDataController.text = plantao.data;
    // Supondo que o horário está no formato '08:00-18:00'
    final partes = plantao.horario.split('-');
    plantaoHorarioInicioController.text = partes.isNotEmpty ? partes[0] : '';
    plantaoHorarioFimController.text = partes.length > 1 ? partes[1] : '';
    update();
  }

  void backToPlantoesList() {
    selectedSubModule = 'plantoes_list';
    plantaoToEdit = null;
    plantaoMedicoNomeController.clear();
    plantaoDataController.clear();
    plantaoHorarioController.clear();
    update();
  }

  void createPlantao() {
    final horario =
        '${plantaoHorarioInicioController.text}-${plantaoHorarioFimController.text}';
    final novo = PlantaoModel(
      id: plantoes.isNotEmpty ? plantoes.last.id + 1 : 1,
      medicoNome: plantaoMedicoNomeController.text,
      data: plantaoDataController.text,
      horario: horario,
    );
    plantoes.add(novo);
    filteredPlantoes.add(novo);
    backToPlantoesList();
  }

  void updatePlantao() {
    if (plantaoToEdit == null) return;
    final horario =
        '${plantaoHorarioInicioController.text}-${plantaoHorarioFimController.text}';
    final index = plantoes.indexWhere((p) => p.id == plantaoToEdit!.id);
    if (index != -1) {
      plantoes[index] = PlantaoModel(
        id: plantaoToEdit!.id,
        medicoNome: plantaoMedicoNomeController.text,
        data: plantaoDataController.text,
        horario: horario,
      );
      filteredPlantoes = List.from(plantoes);
    }
    backToPlantoesList();
  }

  void deletePlantao(PlantaoModel plantao) {
    plantoes.removeWhere((p) => p.id == plantao.id);
    filteredPlantoes.removeWhere((p) => p.id == plantao.id);
    backToPlantoesList();
  }

  void searchPlantoes(String query) {
    if (query.isEmpty) {
      filteredPlantoes = List.from(plantoes);
    } else {
      filteredPlantoes =
          plantoes
              .where(
                (p) => p.medicoNome.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    update();
  }

  void toggleSearchModePlantoes() {
    isSearchModePlantoes = !isSearchModePlantoes;
    if (!isSearchModePlantoes) {
      plantaoSearchController.clear();
      filteredPlantoes = List.from(plantoes);
    }
    update();
  }

  // Alternar entre médicos e plantões
  void goToMedicos() {
    selectedSubModule = 'medicos_list';
    update();
  }

  void goToPlantoes() {
    selectedSubModule = 'plantoes_list';
    update();
  }

  void goToHospitais() {
    selectedSubModule = 'hospitais';
    update();
  }

  void goToCreateHospital() {
    hospitalToEdit = null;
    hospitalNomeController.clear();
    hospitalEnderecoController.clear();
    selectedSubModule = 'hospital_create';
    update();
  }

  void searchHospitais(String query) {
    if (query.isEmpty) {
      filteredHospitais = List.from(hospitais);
    } else {
      filteredHospitais =
          hospitais
              .where((h) => h.nome.toLowerCase().contains(query.toLowerCase()))
              .toList();
    }
    update();
  }

  void backToHospitaisList() {
    selectedSubModule = 'hospitais';
    hospitalToEdit = null;
    hospitalNomeController.clear();
    hospitalEnderecoController.clear();
    update();
  }

  void createHospital() {
    final novo = HospitalModel(
      id: hospitais.isNotEmpty ? hospitais.last.id + 1 : 1,
      nome: hospitalNomeController.text,
      endereco: hospitalEnderecoController.text,
    );
    hospitais.add(novo);
    filteredHospitais.add(novo);
    backToHospitaisList();
  }

  void goToEditHospital(HospitalModel hospital) {
    hospitalToEdit = hospital;
    hospitalNomeController.text = hospital.nome;
    hospitalEnderecoController.text = hospital.endereco;
    selectedSubModule = 'hospital_edit';
    update();
  }

  void deleteHospital(HospitalModel hospital) {
    hospitais.removeWhere((h) => h.id == hospital.id);
    filteredHospitais.removeWhere((h) => h.id == hospital.id);
    update();
  }

  void updateHospital() {
    if (hospitalToEdit == null) return;
    final index = hospitais.indexWhere((h) => h.id == hospitalToEdit!.id);
    if (index != -1) {
      hospitais[index] = HospitalModel(
        id: hospitalToEdit!.id,
        nome: hospitalNomeController.text,
        endereco: hospitalEnderecoController.text,
      );
      filteredHospitais = List.from(hospitais);
    }
    backToHospitaisList();
  }
}
