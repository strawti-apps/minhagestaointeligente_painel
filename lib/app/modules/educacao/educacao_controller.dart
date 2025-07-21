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

  int subPage = 0; // 0: escolas, 1: professores, 2: alunos
  Professor? professorVisualizando;

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
}
