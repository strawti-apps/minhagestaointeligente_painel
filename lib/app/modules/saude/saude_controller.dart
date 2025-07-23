import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicoModel {
  final int id;
  final String nome;
  final String especialidade;
  final String crm;
  final String? email;
  final String? telefone;
  final String? hospital;
  final String? imagem;
  MedicoModel({
    required this.id,
    required this.nome,
    required this.especialidade,
    required this.crm,
    this.email,
    this.telefone,
    this.hospital,
    this.imagem,
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
  final String? telefone;
  final String? email;
  final String? tipo; // Público, Privado, Filantrópico
  final int? capacidade;
  final String? imagem;
  HospitalModel({
    required this.id,
    required this.nome,
    required this.endereco,
    this.telefone,
    this.email,
    this.tipo,
    this.capacidade,
    this.imagem,
  });
}

class SaudeController extends GetxController {
  // Médicos
  List<MedicoModel> medicos = [
    MedicoModel(
      id: 1,
      nome: 'Dra. Ana Silva Santos',
      especialidade: 'Cardiologia',
      crm: '12345-SP',
      email: 'ana.silva@hospital.com.br',
      telefone: '(11) 99999-1111',
      hospital: 'Hospital Municipal Dr. José Silva',
      imagem:
          'https://tse1.mm.bing.net/th/id/OIP.kyOMNre86zlzL_UNjISJlQHaKv?rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    MedicoModel(
      id: 2,
      nome: 'Dr. João Carlos Souza',
      especialidade: 'Pediatria',
      crm: '67890-SP',
      email: 'joao.souza@hospital.com.br',
      telefone: '(11) 99999-2222',
      hospital: 'Hospital Regional Santa Maria',
      imagem:
          'https://tse2.mm.bing.net/th/id/OIP.5dSvLyhTWRgipNT4lD0ggwHaE8?rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    MedicoModel(
      id: 3,
      nome: 'Dra. Maria Fernanda Costa',
      especialidade: 'Ginecologia',
      crm: '23456-SP',
      email: 'maria.costa@hospital.com.br',
      telefone: '(11) 99999-3333',
      hospital: 'Hospital Santa Luzia',
      imagem: '',
    ),
    MedicoModel(
      id: 4,
      nome: 'Dr. Roberto Almeida Lima',
      especialidade: 'Ortopedia',
      crm: '34567-SP',
      email: 'roberto.lima@hospital.com.br',
      telefone: '(11) 99999-4444',
      hospital: 'Hospital Vida Nova',
      imagem:
          'https://tse4.mm.bing.net/th/id/OIP.uNNgdlf7m2Epc4HbXVgEuwHaHN?w=626&h=609&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    MedicoModel(
      id: 5,
      nome: 'Dra. Juliana Pereira Rodrigues',
      especialidade: 'Dermatologia',
      crm: '45678-SP',
      email: 'juliana.rodrigues@hospital.com.br',
      telefone: '(11) 99999-5555',
      hospital: 'Hospital São Lucas',
      imagem:
          'https://tse3.mm.bing.net/th/id/OIP.lXTeK9ajeQ4MKm_A6CBfygAAAA?w=398&h=591&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    MedicoModel(
      id: 6,
      nome: 'Dr. Carlos Eduardo Mendes',
      especialidade: 'Neurologia',
      crm: '56789-SP',
      email: 'carlos.mendes@hospital.com.br',
      telefone: '(11) 99999-6666',
      hospital: 'Hospital Beneficência Portuguesa',
      imagem:
          'https://tse3.mm.bing.net/th/id/OIP.-iWQZW9FPy1_BaNLL0407AAAAA?w=420&h=480&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    MedicoModel(
      id: 7,
      nome: 'Dra. Patricia Oliveira Silva',
      especialidade: 'Psiquiatria',
      crm: '67890-SP',
      email: 'patricia.silva@hospital.com.br',
      telefone: '(11) 99999-7777',
      hospital: 'Hospital Albert Einstein',
      imagem:
          'https://tse1.mm.bing.net/th/id/OIP.EGFjka5J-jemA7CpRm7mywHaKx?w=530&h=771&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    MedicoModel(
      id: 8,
      nome: 'Dr. Fernando Santos Costa',
      especialidade: 'Urologia',
      crm: '78901-SP',
      email: 'fernando.costa@hospital.com.br',
      telefone: '(11) 99999-8888',
      hospital: 'Hospital Sírio-Libanês',
      imagem: '',
    ),
    MedicoModel(
      id: 9,
      nome: 'Dra. Camila Rodrigues Alves',
      especialidade: 'Oftalmologia',
      crm: '89012-SP',
      email: 'camila.alves@hospital.com.br',
      telefone: '(11) 99999-9999',
      hospital: 'Hospital das Clínicas',
      imagem:
          'https://tse2.mm.bing.net/th/id/OIP.Zs-8zN9qmFZoWmac-icvNgHaIi?rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    MedicoModel(
      id: 10,
      nome: 'Dr. Ricardo Mendes Pereira',
      especialidade: 'Endocrinologia',
      crm: '90123-SP',
      email: 'ricardo.pereira@hospital.com.br',
      telefone: '(11) 99999-0000',
      hospital: 'Hospital Santa Casa de Misericórdia',
      imagem: '',
    ),
    MedicoModel(
      id: 11,
      nome: 'Dra. Beatriz Silva Costa',
      especialidade: 'Oncologia',
      crm: '01234-SP',
      email: 'beatriz.costa@hospital.com.br',
      telefone: '(11) 99999-1112',
      hospital: 'Hospital São Camilo',
      imagem:
          'https://png.pngtree.com/png-vector/20240518/ourmid/pngtree-photo-of-smiling-doctor-woman-png-image_12381058.png',
    ),
    MedicoModel(
      id: 12,
      nome: 'Dr. Alexandre Costa Santos',
      especialidade: 'Cirurgia Geral',
      crm: '12345-SP',
      email: 'alexandre.santos@hospital.com.br',
      telefone: '(11) 99999-1113',
      hospital: 'Hospital Nove de Julho',
      imagem:
          'https://img.imageboss.me/revista-cdn/cdn/41938/7d8429c45731acf5a27316ce946ece4f005b8947.jpg?1666045869',
    ),
  ];
  List<MedicoModel> filteredMedicos = [];
  MedicoModel? medicoToEdit;
  final TextEditingController medicoNomeController = TextEditingController();
  final TextEditingController medicoEspecialidadeController =
      TextEditingController();
  final TextEditingController medicoCrmController = TextEditingController();
  final TextEditingController medicoEmailController = TextEditingController();
  final TextEditingController medicoTelefoneController =
      TextEditingController();
  final TextEditingController medicoHospitalController =
      TextEditingController();
  final TextEditingController medicoImagemController = TextEditingController();
  final TextEditingController medicoSearchController = TextEditingController();

  // Plantões
  List<PlantaoModel> plantoes = [
    PlantaoModel(
      id: 1,
      medicoNome: 'Dra. Ana Silva Santos',
      data: '2024-06-01',
      horario: '18:00-06:00', // Noturno
    ),
    PlantaoModel(
      id: 2,
      medicoNome: 'Dr. João Carlos Souza',
      data: '2024-06-02',
      horario: '08:00-18:00', // Diurno
    ),
    PlantaoModel(
      id: 3,
      medicoNome: 'Dra. Maria Fernanda Costa',
      data: '2024-06-03',
      horario: '18:00-06:00', // Noturno
    ),
    PlantaoModel(
      id: 4,
      medicoNome: 'Dr. Roberto Almeida Lima',
      data: '2024-06-04',
      horario: '08:00-18:00', // Diurno
    ),
    PlantaoModel(
      id: 5,
      medicoNome: 'Dra. Juliana Pereira Rodrigues',
      data: '2024-06-05',
      horario: '08:00-18:00', // Diurno
    ),
    PlantaoModel(
      id: 6,
      medicoNome: 'Dr. Carlos Eduardo Mendes',
      data: '2024-06-06',
      horario: '08:00-18:00', // Diurno
    ),
    PlantaoModel(
      id: 7,
      medicoNome: 'Dra. Patricia Oliveira Silva',
      data: '2024-06-07',
      horario: '08:00-18:00', // Diurno
    ),
    PlantaoModel(
      id: 8,
      medicoNome: 'Dr. Fernando Santos Costa',
      data: '2024-06-08',
      horario: '18:00-06:00', // Noturno
    ),
    PlantaoModel(
      id: 9,
      medicoNome: 'Dra. Camila Rodrigues Alves',
      data: '2024-06-09',
      horario: '08:00-18:00', // Diurno
    ),
    PlantaoModel(
      id: 10,
      medicoNome: 'Dr. Ricardo Mendes Pereira',
      data: '2024-06-10',
      horario: '18:00-06:00', // Noturno
    ),
    PlantaoModel(
      id: 11,
      medicoNome: 'Dra. Beatriz Silva Costa',
      data: '2024-06-11',
      horario: '08:00-18:00', // Diurno
    ),
    PlantaoModel(
      id: 12,
      medicoNome: 'Dr. Alexandre Costa Santos',
      data: '2024-06-12',
      horario: '08:00-18:00', // Diurno
    ),
    PlantaoModel(
      id: 13,
      medicoNome: 'Dra. Ana Silva Santos',
      data: '2024-06-13',
      horario: '08:00-18:00', // Diurno
    ),
    PlantaoModel(
      id: 14,
      medicoNome: 'Dr. João Carlos Souza',
      data: '2024-06-14',
      horario: '18:00-06:00', // Noturno
    ),
    PlantaoModel(
      id: 15,
      medicoNome: 'Dra. Maria Fernanda Costa',
      data: '2024-06-15',
      horario: '08:00-18:00', // Diurno
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
  final TextEditingController hospitalTelefoneController =
      TextEditingController();
  final TextEditingController hospitalEmailController = TextEditingController();
  final TextEditingController hospitalTipoController = TextEditingController();
  final TextEditingController hospitalCapacidadeController =
      TextEditingController();
  final TextEditingController hospitalImagemController =
      TextEditingController();

  List<HospitalModel> hospitais = [
    HospitalModel(
      id: 1,
      nome: 'Hospital Municipal Dr. José Silva',
      endereco: 'Rua Central, 100 - Centro, São Paulo/SP',
      telefone: '(11) 3333-1111',
      email: 'contato@hospitalsilva.com.br',
      tipo: 'Público',
      capacidade: 150,
      imagem:
          'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?w=400&h=300&fit=crop',
    ),
    HospitalModel(
      id: 2,
      nome: 'Hospital Regional Santa Maria',
      endereco: 'Av. Brasil, 200 - Vila Nova, São Paulo/SP',
      telefone: '(11) 3333-2222',
      email: 'contato@hospitalsantamaria.com.br',
      tipo: 'Público',
      capacidade: 200,
      imagem:
          'https://tse4.mm.bing.net/th/id/OIP.FeVT86LNu5197dsXjDUmiwHaED?w=593&h=325&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    HospitalModel(
      id: 3,
      nome: 'Hospital Santa Luzia',
      endereco: 'Rua das Flores, 300 - Jardim Europa, São Paulo/SP',
      telefone: '(11) 3333-3333',
      email: 'contato@hospitalsantaluzia.com.br',
      tipo: 'Privado',
      capacidade: 80,
      imagem:
          'https://th.bing.com/th/id/R.b9b2c6e78238f5794b9bbd18a8e212f0?rik=GGzOgVp6KDIIdw&riu=http%3a%2f%2fphotos.wikimapia.org%2fp%2f00%2f02%2f17%2f71%2f66_full.jpeg&ehk=bQAhZcZ0JDZWOMhCjPQdopDT%2boU2RfvqjyMzGAY%2bskc%3d&risl=&pid=ImgRaw&r=0',
    ),
    HospitalModel(
      id: 4,
      nome: 'Hospital Vida Nova',
      endereco: 'Av. das Nações, 400 - Mooca, São Paulo/SP',
      telefone: '(11) 3333-4444',
      email: 'contato@hospitalvidanova.com.br',
      tipo: 'Filantrópico',
      capacidade: 120,
      imagem:
          'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=300&fit=crop',
    ),
    HospitalModel(
      id: 5,
      nome: 'Hospital São Lucas',
      endereco: 'Rua São João, 500 - Santana, São Paulo/SP',
      telefone: '(11) 3333-5555',
      email: 'contato@hospitalsaolucas.com.br',
      tipo: 'Privado',
      capacidade: 100,
      imagem:
          'https://portaldeamericana.com/wp-content/uploads/2020/12/fotor_1609341191182_copy_800x450-800x400.jpg',
    ),
    HospitalModel(
      id: 6,
      nome: 'Hospital Beneficência Portuguesa',
      endereco: 'Av. Paulista, 600 - Bela Vista, São Paulo/SP',
      telefone: '(11) 3333-6666',
      email: 'contato@beneficencia.com.br',
      tipo: 'Filantrópico',
      capacidade: 300,
      imagem:
          'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=300&fit=crop',
    ),
    HospitalModel(
      id: 7,
      nome: 'Hospital Albert Einstein',
      endereco: 'Av. Albert Einstein, 700 - Morumbi, São Paulo/SP',
      telefone: '(11) 3333-7777',
      email: 'contato@einstein.com.br',
      tipo: 'Privado',
      capacidade: 500,
      imagem:
          'https://guiadoestudante.abril.com.br/wp-content/uploads/sites/4/2022/09/1649242019637_2022.04.05_e6_0001.jpg?quality=100&strip=info&w=1024&crop=1',
    ),
    HospitalModel(
      id: 8,
      nome: 'Hospital Sírio-Libanês',
      endereco: 'Rua Dona Adma Jafet, 800 - Bela Vista, São Paulo/SP',
      telefone: '(11) 3333-8888',
      email: 'contato@siriolibanes.com.br',
      tipo: 'Filantrópico',
      capacidade: 400,
      imagem:
          'https://tse2.mm.bing.net/th/id/OIP.IotpoH5enQ1SZNRS-rSDmgHaEt?rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    HospitalModel(
      id: 9,
      nome: 'Hospital das Clínicas',
      endereco:
          'Av. Dr. Enéas de Carvalho Aguiar, 900 - Cerqueira César, São Paulo/SP',
      telefone: '(11) 3333-9999',
      email: 'contato@hc.fm.usp.br',
      tipo: 'Público',
      capacidade: 800,
      imagem:
          'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?w=400&h=300&fit=crop',
    ),
    HospitalModel(
      id: 10,
      nome: 'Hospital Santa Casa de Misericórdia',
      endereco:
          'Rua Dr. Cesário Motta Júnior, 1000 - Vila Buarque, São Paulo/SP',
      telefone: '(11) 3333-0000',
      email: 'contato@santacasa.com.br',
      tipo: 'Filantrópico',
      capacidade: 600,
      imagem:
          'https://th.bing.com/th/id/R.87f6ebaa2285f0b7b1e3d91f044d7b12?rik=boIETx06JfSl%2bw&riu=http%3a%2f%2fviajantesemfim.com.br%2fwp-content%2fuploads%2f2019%2f08%2f67796081_685250201886566_5871890299940241408_n.jpg&ehk=9bAtS77rOqUI4NJZb740fghRI8hJX0KPOkAfeLGHGqk%3d&risl=&pid=ImgRaw&r=0',
    ),
    HospitalModel(
      id: 11,
      nome: 'Hospital São Camilo',
      endereco: 'Rua Raul Pompeia, 1100 - Vila Pompeia, São Paulo/SP',
      telefone: '(11) 3333-1112',
      email: 'contato@saocamilo.com.br',
      tipo: 'Filantrópico',
      capacidade: 250,
    ),
    HospitalModel(
      id: 12,
      nome: 'Hospital Nove de Julho',
      endereco: 'Rua Peixoto Gomide, 1200 - Cerqueira César, São Paulo/SP',
      telefone: '(11) 3333-1113',
      email: 'contato@9dejulho.com.br',
      tipo: 'Privado',
      capacidade: 180,
      imagem:
          'https://1.bp.blogspot.com/-kc6xjiXgiWc/X6QN4J1SyQI/AAAAAAAAVbg/wY9SUleEScgmcM3NQia-YvxcL30rJkWYwCPcBGAYYCw/s1024/Hospital%2BNove%2Bde%2BJulho.jpg',
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
    medicoEmailController.clear();
    medicoTelefoneController.clear();
    medicoHospitalController.clear();
    medicoImagemController.clear();
    update();
  }

  void goToEditMedico(MedicoModel medico) {
    selectedSubModule = 'medico_edit';
    medicoToEdit = medico;
    medicoNomeController.text = medico.nome;
    medicoEspecialidadeController.text = medico.especialidade;
    medicoCrmController.text = medico.crm;
    medicoEmailController.text = medico.email ?? '';
    medicoTelefoneController.text = medico.telefone ?? '';
    medicoHospitalController.text = medico.hospital ?? '';
    medicoImagemController.text = medico.imagem ?? '';
    update();
  }

  void backToMedicosList() {
    selectedSubModule = 'medicos_list';
    medicoToEdit = null;
    medicoNomeController.clear();
    medicoEspecialidadeController.clear();
    medicoCrmController.clear();
    medicoEmailController.clear();
    medicoTelefoneController.clear();
    medicoHospitalController.clear();
    medicoImagemController.clear();
    update();
  }

  void createMedico() {
    final novo = MedicoModel(
      id: medicos.isNotEmpty ? medicos.last.id + 1 : 1,
      nome: medicoNomeController.text,
      especialidade: medicoEspecialidadeController.text,
      crm: medicoCrmController.text,
      email:
          medicoEmailController.text.isNotEmpty
              ? medicoEmailController.text
              : null,
      telefone:
          medicoTelefoneController.text.isNotEmpty
              ? medicoTelefoneController.text
              : null,
      hospital:
          medicoHospitalController.text.isNotEmpty
              ? medicoHospitalController.text
              : null,
      imagem:
          medicoImagemController.text.isNotEmpty
              ? medicoImagemController.text
              : null,
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
        email:
            medicoEmailController.text.isNotEmpty
                ? medicoEmailController.text
                : null,
        telefone:
            medicoTelefoneController.text.isNotEmpty
                ? medicoTelefoneController.text
                : null,
        hospital:
            medicoHospitalController.text.isNotEmpty
                ? medicoHospitalController.text
                : null,
        imagem:
            medicoImagemController.text.isNotEmpty
                ? medicoImagemController.text
                : null,
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
    hospitalTelefoneController.clear();
    hospitalEmailController.clear();
    hospitalTipoController.clear();
    hospitalCapacidadeController.clear();
    hospitalImagemController.clear();
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
    hospitalTelefoneController.clear();
    hospitalEmailController.clear();
    hospitalTipoController.clear();
    hospitalCapacidadeController.clear();
    hospitalImagemController.clear();
    update();
  }

  void createHospital() {
    final novo = HospitalModel(
      id: hospitais.isNotEmpty ? hospitais.last.id + 1 : 1,
      nome: hospitalNomeController.text,
      endereco: hospitalEnderecoController.text,
      telefone:
          hospitalTelefoneController.text.isNotEmpty
              ? hospitalTelefoneController.text
              : null,
      email:
          hospitalEmailController.text.isNotEmpty
              ? hospitalEmailController.text
              : null,
      tipo:
          hospitalTipoController.text.isNotEmpty
              ? hospitalTipoController.text
              : null,
      capacidade:
          hospitalCapacidadeController.text.isNotEmpty
              ? int.tryParse(hospitalCapacidadeController.text)
              : null,
      imagem:
          hospitalImagemController.text.isNotEmpty
              ? hospitalImagemController.text
              : null,
    );
    hospitais.add(novo);
    filteredHospitais.add(novo);
    backToHospitaisList();
  }

  void goToEditHospital(HospitalModel hospital) {
    hospitalToEdit = hospital;
    hospitalNomeController.text = hospital.nome;
    hospitalEnderecoController.text = hospital.endereco;
    hospitalTelefoneController.text = hospital.telefone ?? '';
    hospitalEmailController.text = hospital.email ?? '';
    hospitalTipoController.text = hospital.tipo ?? '';
    hospitalCapacidadeController.text = hospital.capacidade?.toString() ?? '';
    hospitalImagemController.text = hospital.imagem ?? '';
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
        telefone:
            hospitalTelefoneController.text.isNotEmpty
                ? hospitalTelefoneController.text
                : null,
        email:
            hospitalEmailController.text.isNotEmpty
                ? hospitalEmailController.text
                : null,
        tipo:
            hospitalTipoController.text.isNotEmpty
                ? hospitalTipoController.text
                : null,
        capacidade:
            hospitalCapacidadeController.text.isNotEmpty
                ? int.tryParse(hospitalCapacidadeController.text)
                : null,
        imagem:
            hospitalImagemController.text.isNotEmpty
                ? hospitalImagemController.text
                : null,
      );
      filteredHospitais = List.from(hospitais);
    }
    backToHospitaisList();
  }
}
