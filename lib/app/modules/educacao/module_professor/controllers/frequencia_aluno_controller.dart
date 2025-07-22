import 'package:get/get.dart';

class FrequenciaAlunoController extends GetxController {
  final alunos = [
    {'nome': 'Lucas Martins', 'turma': '5º Ano A', 'presente': true},
    {'nome': 'Julia Rocha', 'turma': '4º Ano B', 'presente': false},
    {'nome': 'Pedro Henrique', 'turma': '3º Ano C', 'presente': true},
    {'nome': 'Ana Beatriz', 'turma': '5º Ano B', 'presente': false},
    {'nome': 'Carlos Eduardo', 'turma': '2º Ano A', 'presente': true},
    {'nome': 'Mariana Silva', 'turma': '1º Ano C', 'presente': false},
    {'nome': 'Rafael Lima', 'turma': '3º Ano B', 'presente': true},
  ];

  void togglePresenca(int index) {
    alunos[index]['presente'] = !(alunos[index]['presente'] as bool);
    update();
  }
}
