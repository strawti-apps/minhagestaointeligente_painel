import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Escola {
  final int id;
  final String nome;
  final String tipo; // Escola ou Creche
  final String endereco;
  final String? telefone;
  final String? email;
  final int? capacidade;
  final String? turnos; // Matutino, Vespertino, Integral
  final String? imagem;
  Escola({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.endereco,
    this.telefone,
    this.email,
    this.capacidade,
    this.turnos,
    this.imagem,
  });
}

class Professor {
  final int id;
  final String nome;
  final String disciplina;
  final String email;
  final String? telefone;
  final String? escola;
  final String? especialidade;
  final String? imagem;
  Professor({
    required this.id,
    required this.nome,
    required this.disciplina,
    required this.email,
    this.telefone,
    this.escola,
    this.especialidade,
    this.imagem,
  });
}

class Aluno {
  final int id;
  final String nome;
  final String turma;
  final String responsavel;
  final int? idade;
  final String? escola;
  final String? telefone;
  final String? imagem;
  Aluno({
    required this.id,
    required this.nome,
    required this.turma,
    required this.responsavel,
    this.idade,
    this.escola,
    this.telefone,
    this.imagem,
  });
}

class EducacaoController extends GetxController {
  List<Escola> escolas = [
    Escola(
      id: 1,
      nome: 'EMEF Prefeito João',
      tipo: 'Escola',
      endereco: 'Rua das Flores, 123 - Centro, São Paulo/SP',
      telefone: '(11) 3333-1111',
      email: 'contato@emefprefeitojoao.com.br',
      capacidade: 800,
      turnos: 'Matutino e Vespertino',
      imagem:
          'https://img.gothru.org/pano_zoom.php?p=40751522&i=1695/4073980081240294302/20230710205240.N8cTwA.jpg&w=1200&h=630&a=40&y=358.61&v=1',
    ),
    Escola(
      id: 2,
      nome: 'Creche Mundo Feliz',
      tipo: 'Creche',
      endereco: 'Av. Central, 456 - Vila Nova, São Paulo/SP',
      telefone: '(11) 3333-2222',
      email: 'contato@crechemundofeliz.com.br',
      capacidade: 120,
      turnos: 'Integral',
      imagem:
          'https://th.bing.com/th/id/R.cc529eb5132381b1b01e06173906a300?rik=XDNySRMpOlKoIw&pid=ImgRaw&r=0',
    ),
    Escola(
      id: 3,
      nome: 'EMEF Dona Maria',
      tipo: 'Escola',
      endereco: 'Rua Nova, 789 - Jardim Europa, São Paulo/SP',
      telefone: '(11) 3333-3333',
      email: 'contato@emefdonamaria.com.br',
      capacidade: 600,
      turnos: 'Matutino e Vespertino',
      imagem:
          'https://img.gothru.org/pano_zoom.php?p=40751522&i=1695/4073980081240294302/20230710205240.N8cTwA.jpg&w=1200&h=630&a=40&y=358.61&v=1',
    ),
    Escola(
      id: 4,
      nome: 'EMEF Professor Carlos Silva',
      tipo: 'Escola',
      endereco: 'Av. das Nações, 321 - Mooca, São Paulo/SP',
      telefone: '(11) 3333-4444',
      email: 'contato@emefcarlossilva.com.br',
      capacidade: 750,
      turnos: 'Matutino, Vespertino e Noturno',
      imagem:
          'https://img.gothru.org/pano_zoom.php?p=40751522&i=1695/4073980081240294302/20230710205240.N8cTwA.jpg&w=1200&h=630&a=40&y=358.61&v=1',
    ),
    Escola(
      id: 5,
      nome: 'Creche Pequenos Anjos',
      tipo: 'Creche',
      endereco: 'Rua São João, 654 - Santana, São Paulo/SP',
      telefone: '(11) 3333-5555',
      email: 'contato@crechepequenosanjos.com.br',
      capacidade: 80,
      turnos: 'Integral',
      imagem:
          'https://th.bing.com/th/id/R.90dc3557d43d9d1472002c6def66f69b?rik=NAUhXGMx7ZW0yw&pid=ImgRaw&r=0',
    ),
    Escola(
      id: 6,
      nome: 'EMEF Santos Dumont',
      tipo: 'Escola',
      endereco: 'Av. Paulista, 987 - Bela Vista, São Paulo/SP',
      telefone: '(11) 3333-6666',
      email: 'contato@emefsantosdumont.com.br',
      capacidade: 900,
      turnos: 'Matutino e Vespertino',
      imagem:
          'https://img.gothru.org/pano_zoom.php?p=40751522&i=1695/4073980081240294302/20230710205240.N8cTwA.jpg&w=1200&h=630&a=40&y=358.61&v=1',
    ),
  ];
  List<Escola> filteredEscolas = [];

  List<Professor> professores = [
    Professor(
      id: 1,
      nome: 'Ana Paula Silva',
      disciplina: 'Matemática',
      email: 'ana.paula@escola.com',
      telefone: '(11) 99999-1111',
      escola: 'EMEF Prefeito João',
      especialidade: 'Matemática Fundamental',
      imagem:
          'https://tse4.mm.bing.net/th/id/OIP.ZhhQMuT0nlzzpNfJSnPiMwHaEJ?rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    Professor(
      id: 2,
      nome: 'Carlos Silva Santos',
      disciplina: 'Português',
      email: 'carlos.silva@escola.com',
      telefone: '(11) 99999-2222',
      escola: 'EMEF Dona Maria',
      especialidade: 'Língua Portuguesa',
      imagem:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=300&fit=crop',
    ),
    Professor(
      id: 3,
      nome: 'Fernanda Souza Costa',
      disciplina: 'Ciências',
      email: 'fernanda.souza@escola.com',
      telefone: '(11) 99999-3333',
      escola: 'EMEF Professor Carlos Silva',
      especialidade: 'Ciências Naturais',
      imagem:
          'https://tse2.mm.bing.net/th/id/OIP.U1hNWExdF2E4Gukg7JyQjgHaEJ?w=626&h=351&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    Professor(
      id: 4,
      nome: 'Roberto Almeida Lima',
      disciplina: 'História',
      email: 'roberto.lima@escola.com',
      telefone: '(11) 99999-4444',
      escola: 'EMEF Santos Dumont',
      especialidade: 'História do Brasil',
      imagem:
          'https://tse3.mm.bing.net/th/id/OIP.foTu_vxO8y8sHLooNBKqbQHaE7?rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    Professor(
      id: 5,
      nome: 'Juliana Pereira Rodrigues',
      disciplina: 'Geografia',
      email: 'juliana.rodrigues@escola.com',
      telefone: '(11) 99999-5555',
      escola: 'EMEF Prefeito João',
      especialidade: 'Geografia Humana',
      imagem:
          'https://t3.ftcdn.net/jpg/06/52/18/44/360_F_652184417_jDWvx57dWX6mjokB15G9KwpR2nMSLjtD.jpg',
    ),
    Professor(
      id: 6,
      nome: 'Carlos Eduardo Mendes',
      disciplina: 'Educação Física',
      email: 'carlos.mendes@escola.com',
      telefone: '(11) 99999-6666',
      escola: 'EMEF Dona Maria',
      especialidade: 'Esportes e Atividades Físicas',
      imagem:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=300&fit=crop',
    ),
  ];
  List<Professor> filteredProfessores = [];

  List<Aluno> alunos = [
    Aluno(
      id: 1,
      nome: 'Lucas Martins Silva',
      turma: '5º Ano A',
      responsavel: 'Maria Martins Silva',
      idade: 10,
      escola: 'EMEF Prefeito João',
      telefone: '(11) 99999-7777',
      imagem:
          'https://tse2.mm.bing.net/th/id/OIP._IhBIxJ8I7apyHvrSj80QgHaE7?rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    Aluno(
      id: 2,
      nome: 'Julia Rocha Costa',
      turma: '4º Ano B',
      responsavel: 'Paulo Rocha Costa',
      idade: 9,
      escola: 'EMEF Dona Maria',
      telefone: '(11) 99999-8888',
      imagem:
          'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?w=400&h=300&fit=crop',
    ),
    Aluno(
      id: 3,
      nome: 'Pedro Henrique Santos',
      turma: '3º Ano C',
      responsavel: 'Ana Henrique Santos',
      idade: 8,
      escola: 'EMEF Professor Carlos Silva',
      telefone: '(11) 99999-9999',
      imagem:
          'https://tse2.mm.bing.net/th/id/OIP.8nyaJJyxoVDtQyIh0zVfUgHaHa?w=626&h=626&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    Aluno(
      id: 4,
      nome: 'Mariana Oliveira Lima',
      turma: '6º Ano A',
      responsavel: 'Carlos Oliveira Lima',
      idade: 11,
      escola: 'EMEF Santos Dumont',
      telefone: '(11) 99999-0000',
      imagem:
          'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?w=400&h=300&fit=crop',
    ),
    Aluno(
      id: 5,
      nome: 'Gabriel Pereira Rodrigues',
      turma: '2º Ano A',
      responsavel: 'Fernanda Pereira Rodrigues',
      idade: 7,
      escola: 'EMEF Prefeito João',
      telefone: '(11) 99999-1111',
      imagem:
          'https://tse1.mm.bing.net/th/id/OIP.ruhG3JXpSO0eczAKlpRaoQHaHa?w=826&h=826&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    Aluno(
      id: 6,
      nome: 'Sofia Mendes Alves',
      turma: '1º Ano B',
      responsavel: 'Roberto Mendes Alves',
      idade: 6,
      escola: 'EMEF Dona Maria',
      telefone: '(11) 99999-2222',
      imagem:
          'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?w=400&h=300&fit=crop',
    ),
  ];
  List<Aluno> filteredAlunos = [];

  int subPage = 0; // 0: escolas, 1: professores, 2: alunos
  Professor? professorVisualizando;

  // Estados para criação/edição
  Escola? escolaToEdit;
  Professor? professorToEdit;
  Aluno? alunoToEdit;

  // Controllers para formulários
  final escolaNomeController = TextEditingController();
  final escolaTipoController = TextEditingController();
  final escolaEnderecoController = TextEditingController();
  final escolaTelefoneController = TextEditingController();
  final escolaEmailController = TextEditingController();
  final escolaCapacidadeController = TextEditingController();
  final escolaTurnosController = TextEditingController();
  final escolaImagemController = TextEditingController();

  final professorNomeController = TextEditingController();
  final professorDisciplinaController = TextEditingController();
  final professorEmailController = TextEditingController();
  final professorTelefoneController = TextEditingController();
  final professorEscolaController = TextEditingController();
  final professorEspecialidadeController = TextEditingController();
  final professorImagemController = TextEditingController();

  final alunoNomeController = TextEditingController();
  final alunoTurmaController = TextEditingController();
  final alunoResponsavelController = TextEditingController();
  final alunoIdadeController = TextEditingController();
  final alunoEscolaController = TextEditingController();
  final alunoTelefoneController = TextEditingController();
  final alunoImagemController = TextEditingController();

  // Estado de exibição do formulário
  String? creatingEditing; // 'escola', 'professor', 'aluno'
  bool isEditing = false;

  @override
  void onInit() {
    super.onInit();
    filteredEscolas = List.from(escolas);
    filteredProfessores = List.from(professores);
    filteredAlunos = List.from(alunos);
  }

  void irParaEscolas() {
    subPage = 0;
    professorVisualizando = null;
    update();
  }

  void irParaProfessores() {
    subPage = 1;
    professorVisualizando = null;
    update();
  }

  void irParaAlunos() {
    subPage = 2;
    professorVisualizando = null;
    update();
  }

  void visualizarComoProfessor(Professor prof) {
    professorVisualizando = prof;
    update();
  }

  void voltarVisualizacaoProfessor() {
    professorVisualizando = null;
    update();
  }

  // Métodos para abrir formulários
  void openCreateEscola() {
    creatingEditing = 'escola';
    isEditing = false;
    escolaToEdit = null;
    escolaNomeController.clear();
    escolaTipoController.clear();
    escolaEnderecoController.clear();
    escolaTelefoneController.clear();
    escolaEmailController.clear();
    escolaCapacidadeController.clear();
    escolaTurnosController.clear();
    escolaImagemController.clear();
    update();
  }

  void openEditEscola(Escola escola) {
    creatingEditing = 'escola';
    isEditing = true;
    escolaToEdit = escola;
    escolaNomeController.text = escola.nome;
    escolaTipoController.text = escola.tipo;
    escolaEnderecoController.text = escola.endereco;
    escolaTelefoneController.text = escola.telefone ?? '';
    escolaEmailController.text = escola.email ?? '';
    escolaCapacidadeController.text = escola.capacidade?.toString() ?? '';
    escolaTurnosController.text = escola.turnos ?? '';
    escolaImagemController.text = escola.imagem ?? '';
    update();
  }

  void closeForm() {
    creatingEditing = null;
    isEditing = false;
    escolaToEdit = null;
    professorToEdit = null;
    alunoToEdit = null;
    escolaNomeController.clear();
    escolaTipoController.clear();
    escolaEnderecoController.clear();
    escolaTelefoneController.clear();
    escolaEmailController.clear();
    escolaCapacidadeController.clear();
    escolaTurnosController.clear();
    escolaImagemController.clear();
    professorNomeController.clear();
    professorDisciplinaController.clear();
    professorEmailController.clear();
    professorTelefoneController.clear();
    professorEscolaController.clear();
    professorEspecialidadeController.clear();
    professorImagemController.clear();
    alunoNomeController.clear();
    alunoTurmaController.clear();
    alunoResponsavelController.clear();
    alunoIdadeController.clear();
    alunoEscolaController.clear();
    alunoTelefoneController.clear();
    alunoImagemController.clear();
    update();
  }

  void searchEscolas(String query) {
    if (query.isEmpty) {
      filteredEscolas = List.from(escolas);
    } else {
      filteredEscolas =
          escolas
              .where(
                (e) =>
                    e.nome.toLowerCase().contains(query.toLowerCase()) ||
                    e.tipo.toLowerCase().contains(query.toLowerCase()) ||
                    e.endereco.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    update();
  }

  void searchProfessores(String query) {
    if (query.isEmpty) {
      filteredProfessores = List.from(professores);
    } else {
      filteredProfessores =
          professores
              .where(
                (p) =>
                    p.nome.toLowerCase().contains(query.toLowerCase()) ||
                    p.disciplina.toLowerCase().contains(query.toLowerCase()) ||
                    p.email.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    update();
  }

  void searchAlunos(String query) {
    if (query.isEmpty) {
      filteredAlunos = List.from(alunos);
    } else {
      filteredAlunos =
          alunos
              .where(
                (a) =>
                    a.nome.toLowerCase().contains(query.toLowerCase()) ||
                    a.turma.toLowerCase().contains(query.toLowerCase()) ||
                    a.responsavel.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    update();
  }

  // Ao adicionar/remover/editar, atualizar as listas filtradas também
  void createEscola() {
    final nova = Escola(
      id: escolas.isNotEmpty ? escolas.last.id + 1 : 1,
      nome: escolaNomeController.text,
      tipo: escolaTipoController.text,
      endereco: escolaEnderecoController.text,
      telefone:
          escolaTelefoneController.text.isNotEmpty
              ? escolaTelefoneController.text
              : null,
      email:
          escolaEmailController.text.isNotEmpty
              ? escolaEmailController.text
              : null,
      capacidade:
          escolaCapacidadeController.text.isNotEmpty
              ? int.tryParse(escolaCapacidadeController.text)
              : null,
      turnos:
          escolaTurnosController.text.isNotEmpty
              ? escolaTurnosController.text
              : null,
      imagem:
          escolaImagemController.text.isNotEmpty
              ? escolaImagemController.text
              : null,
    );
    escolas.add(nova);
    filteredEscolas = List.from(escolas);
    closeForm();
    update();
  }

  void updateEscola() {
    if (escolaToEdit == null) return;
    final index = escolas.indexWhere((e) => e.id == escolaToEdit!.id);
    if (index != -1) {
      escolas[index] = Escola(
        id: escolaToEdit!.id,
        nome: escolaNomeController.text,
        tipo: escolaTipoController.text,
        endereco: escolaEnderecoController.text,
        telefone:
            escolaTelefoneController.text.isNotEmpty
                ? escolaTelefoneController.text
                : null,
        email:
            escolaEmailController.text.isNotEmpty
                ? escolaEmailController.text
                : null,
        capacidade:
            escolaCapacidadeController.text.isNotEmpty
                ? int.tryParse(escolaCapacidadeController.text)
                : null,
        turnos:
            escolaTurnosController.text.isNotEmpty
                ? escolaTurnosController.text
                : null,
        imagem:
            escolaImagemController.text.isNotEmpty
                ? escolaImagemController.text
                : null,
      );
      filteredEscolas = List.from(escolas);
    }
    closeForm();
    update();
  }

  void deleteEscola(Escola escola) {
    escolas.removeWhere((e) => e.id == escola.id);
    filteredEscolas = List.from(escolas);
    update();
  }

  // Métodos para Professor
  void openCreateProfessor() {
    creatingEditing = 'professor';
    isEditing = false;
    professorToEdit = null;
    professorNomeController.clear();
    professorDisciplinaController.clear();
    professorEmailController.clear();
    professorTelefoneController.clear();
    professorEscolaController.clear();
    professorEspecialidadeController.clear();
    professorImagemController.clear();
    update();
  }

  void openEditProfessor(Professor prof) {
    creatingEditing = 'professor';
    isEditing = true;
    professorToEdit = prof;
    professorNomeController.text = prof.nome;
    professorDisciplinaController.text = prof.disciplina;
    professorEmailController.text = prof.email;
    professorTelefoneController.text = prof.telefone ?? '';
    professorEscolaController.text = prof.escola ?? '';
    professorEspecialidadeController.text = prof.especialidade ?? '';
    professorImagemController.text = prof.imagem ?? '';
    update();
  }

  void createProfessor() {
    final novo = Professor(
      id: professores.isNotEmpty ? professores.last.id + 1 : 1,
      nome: professorNomeController.text,
      disciplina: professorDisciplinaController.text,
      email: professorEmailController.text,
      telefone:
          professorTelefoneController.text.isNotEmpty
              ? professorTelefoneController.text
              : null,
      escola:
          professorEscolaController.text.isNotEmpty
              ? professorEscolaController.text
              : null,
      especialidade:
          professorEspecialidadeController.text.isNotEmpty
              ? professorEspecialidadeController.text
              : null,
      imagem:
          professorImagemController.text.isNotEmpty
              ? professorImagemController.text
              : null,
    );
    professores.add(novo);
    filteredProfessores = List.from(professores);
    closeForm();
    update();
  }

  void updateProfessor() {
    if (professorToEdit == null) return;
    final index = professores.indexWhere((p) => p.id == professorToEdit!.id);
    if (index != -1) {
      professores[index] = Professor(
        id: professorToEdit!.id,
        nome: professorNomeController.text,
        disciplina: professorDisciplinaController.text,
        email: professorEmailController.text,
        telefone:
            professorTelefoneController.text.isNotEmpty
                ? professorTelefoneController.text
                : null,
        escola:
            professorEscolaController.text.isNotEmpty
                ? professorEscolaController.text
                : null,
        especialidade:
            professorEspecialidadeController.text.isNotEmpty
                ? professorEspecialidadeController.text
                : null,
        imagem:
            professorImagemController.text.isNotEmpty
                ? professorImagemController.text
                : null,
      );
      filteredProfessores = List.from(professores);
    }
    closeForm();
    update();
  }

  void deleteProfessor(Professor prof) {
    professores.removeWhere((p) => p.id == prof.id);
    filteredProfessores = List.from(professores);
    update();
  }

  // Métodos para Aluno
  void openCreateAluno() {
    creatingEditing = 'aluno';
    isEditing = false;
    alunoToEdit = null;
    alunoNomeController.clear();
    alunoTurmaController.clear();
    alunoResponsavelController.clear();
    alunoIdadeController.clear();
    alunoEscolaController.clear();
    alunoTelefoneController.clear();
    alunoImagemController.clear();
    update();
  }

  void openEditAluno(Aluno aluno) {
    creatingEditing = 'aluno';
    isEditing = true;
    alunoToEdit = aluno;
    alunoNomeController.text = aluno.nome;
    alunoTurmaController.text = aluno.turma;
    alunoResponsavelController.text = aluno.responsavel;
    alunoIdadeController.text = aluno.idade?.toString() ?? '';
    alunoEscolaController.text = aluno.escola ?? '';
    alunoTelefoneController.text = aluno.telefone ?? '';
    alunoImagemController.text = aluno.imagem ?? '';
    update();
  }

  void createAluno() {
    final novo = Aluno(
      id: alunos.isNotEmpty ? alunos.last.id + 1 : 1,
      nome: alunoNomeController.text,
      turma: alunoTurmaController.text,
      responsavel: alunoResponsavelController.text,
      idade:
          alunoIdadeController.text.isNotEmpty
              ? int.tryParse(alunoIdadeController.text)
              : null,
      escola:
          alunoEscolaController.text.isNotEmpty
              ? alunoEscolaController.text
              : null,
      telefone:
          alunoTelefoneController.text.isNotEmpty
              ? alunoTelefoneController.text
              : null,
      imagem:
          alunoImagemController.text.isNotEmpty
              ? alunoImagemController.text
              : null,
    );
    alunos.add(novo);
    filteredAlunos = List.from(alunos);
    closeForm();
    update();
  }

  void updateAluno() {
    if (alunoToEdit == null) return;
    final index = alunos.indexWhere((a) => a.id == alunoToEdit!.id);
    if (index != -1) {
      alunos[index] = Aluno(
        id: alunoToEdit!.id,
        nome: alunoNomeController.text,
        turma: alunoTurmaController.text,
        responsavel: alunoResponsavelController.text,
        idade:
            alunoIdadeController.text.isNotEmpty
                ? int.tryParse(alunoIdadeController.text)
                : null,
        escola:
            alunoEscolaController.text.isNotEmpty
                ? alunoEscolaController.text
                : null,
        telefone:
            alunoTelefoneController.text.isNotEmpty
                ? alunoTelefoneController.text
                : null,
        imagem:
            alunoImagemController.text.isNotEmpty
                ? alunoImagemController.text
                : null,
      );
      filteredAlunos = List.from(alunos);
    }
    closeForm();
    update();
  }

  void deleteAluno(Aluno aluno) {
    alunos.removeWhere((a) => a.id == aluno.id);
    filteredAlunos = List.from(alunos);
    update();
  }
}
