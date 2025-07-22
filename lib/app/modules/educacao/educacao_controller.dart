import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Escola {
  final int id;
  final String nome;
  final String tipo; // Escola ou Creche
  final String endereco;
  Escola({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.endereco,
  });
}

class Professor {
  final int id;
  final String nome;
  final String disciplina;
  final String email;
  Professor({
    required this.id,
    required this.nome,
    required this.disciplina,
    required this.email,
  });
}

class Aluno {
  final int id;
  final String nome;
  final String turma;
  final String responsavel;
  Aluno({
    required this.id,
    required this.nome,
    required this.turma,
    required this.responsavel,
  });
}

class EducacaoController extends GetxController {
  List<Escola> escolas = [
    Escola(
      id: 1,
      nome: 'EMEF Prefeito João',
      tipo: 'Escola',
      endereco: 'Rua das Flores, 123',
    ),
    Escola(
      id: 2,
      nome: 'Creche Mundo Feliz',
      tipo: 'Creche',
      endereco: 'Av. Central, 456',
    ),
    Escola(
      id: 3,
      nome: 'EMEF Dona Maria',
      tipo: 'Escola',
      endereco: 'Rua Nova, 789',
    ),
  ];
  List<Escola> filteredEscolas = [];

  List<Professor> professores = [
    Professor(
      id: 1,
      nome: 'Ana Paula',
      disciplina: 'Matemática',
      email: 'ana.paula@escola.com',
    ),
    Professor(
      id: 2,
      nome: 'Carlos Silva',
      disciplina: 'Português',
      email: 'carlos.silva@escola.com',
    ),
    Professor(
      id: 3,
      nome: 'Fernanda Souza',
      disciplina: 'Ciências',
      email: 'fernanda.souza@escola.com',
    ),
  ];
  List<Professor> filteredProfessores = [];

  List<Aluno> alunos = [
    Aluno(
      id: 1,
      nome: 'Lucas Martins',
      turma: '5º Ano A',
      responsavel: 'Maria Martins',
    ),
    Aluno(
      id: 2,
      nome: 'Julia Rocha',
      turma: '4º Ano B',
      responsavel: 'Paulo Rocha',
    ),
    Aluno(
      id: 3,
      nome: 'Pedro Henrique',
      turma: '3º Ano C',
      responsavel: 'Ana Henrique',
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

  final professorNomeController = TextEditingController();
  final professorDisciplinaController = TextEditingController();
  final professorEmailController = TextEditingController();

  final alunoNomeController = TextEditingController();
  final alunoTurmaController = TextEditingController();
  final alunoResponsavelController = TextEditingController();

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
    update();
  }

  void openEditEscola(Escola escola) {
    creatingEditing = 'escola';
    isEditing = true;
    escolaToEdit = escola;
    escolaNomeController.text = escola.nome;
    escolaTipoController.text = escola.tipo;
    escolaEnderecoController.text = escola.endereco;
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
    professorNomeController.clear();
    professorDisciplinaController.clear();
    professorEmailController.clear();
    alunoNomeController.clear();
    alunoTurmaController.clear();
    alunoResponsavelController.clear();
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
    update();
  }

  void openEditProfessor(Professor prof) {
    creatingEditing = 'professor';
    isEditing = true;
    professorToEdit = prof;
    professorNomeController.text = prof.nome;
    professorDisciplinaController.text = prof.disciplina;
    professorEmailController.text = prof.email;
    update();
  }

  void createProfessor() {
    final novo = Professor(
      id: professores.isNotEmpty ? professores.last.id + 1 : 1,
      nome: professorNomeController.text,
      disciplina: professorDisciplinaController.text,
      email: professorEmailController.text,
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
    update();
  }

  void openEditAluno(Aluno aluno) {
    creatingEditing = 'aluno';
    isEditing = true;
    alunoToEdit = aluno;
    alunoNomeController.text = aluno.nome;
    alunoTurmaController.text = aluno.turma;
    alunoResponsavelController.text = aluno.responsavel;
    update();
  }

  void createAluno() {
    final novo = Aluno(
      id: alunos.isNotEmpty ? alunos.last.id + 1 : 1,
      nome: alunoNomeController.text,
      turma: alunoTurmaController.text,
      responsavel: alunoResponsavelController.text,
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
