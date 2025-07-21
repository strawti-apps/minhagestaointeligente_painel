import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedPost {
  final int id;
  final String autor;
  final String conteudo;
  final DateTime data;
  bool bloqueado;
  final List<FeedComment> comentarios;
  final String? imagemUrl;
  FeedPost({
    required this.id,
    required this.autor,
    required this.conteudo,
    required this.data,
    this.bloqueado = false,
    this.comentarios = const [],
    this.imagemUrl,
  });
}

class FeedComment {
  final int id;
  final String autor;
  final String conteudo;
  final DateTime data;
  FeedComment({
    required this.id,
    required this.autor,
    required this.conteudo,
    required this.data,
  });
}

class FeedController extends GetxController {
  List<FeedPost> posts = [
    FeedPost(
      id: 1,
      autor: 'João da Silva',
      conteudo: 'Quando será feita a limpeza da praça?',
      data: DateTime.now().subtract(const Duration(hours: 2)),
      comentarios: [
        FeedComment(
          id: 1,
          autor: 'Prefeitura',
          conteudo: 'A limpeza está programada para amanhã.',
          data: DateTime.now().subtract(const Duration(hours: 1)),
        ),
      ],
      imagemUrl:
          'https://tse3.mm.bing.net/th/id/OIP.bDdYL01gHfxXI0jrE9Nx-gAAAA?rs=1&pid=ImgDetMain&o=7&rm=3', // Praça
    ),
    FeedPost(
      id: 2,
      autor: 'Maria Souza',
      conteudo: 'O poste da rua está queimado faz dias!',
      data: DateTime.now().subtract(const Duration(days: 1)),
      comentarios: [
        FeedComment(
          id: 2,
          autor: 'Secretaria de Obras',
          conteudo: 'Já estamos providenciando a troca.',
          data: DateTime.now().subtract(const Duration(hours: 20)),
        ),
      ],
      imagemUrl:
          'https://cdn.pixabay.com/photo/2022/09/16/17/08/alley-7459180_640.jpg', // Iluminação
    ),
    FeedPost(
      id: 3,
      autor: 'Carlos Lima',
      conteudo: 'Nova praça inaugurada! Veja como ficou linda.',
      data: DateTime.now().subtract(const Duration(days: 2)),
      comentarios: [],
      imagemUrl:
          'https://th.bing.com/th/id/R.75614973264e599d1315a109d43c75d0?rik=FMto8f3mBeiksw&riu=http%3a%2f%2fwww.cuiaba.mt.gov.br%2fstorage%2fwebdisco%2f2019%2f02%2f27%2f800x600%2f217ee58de8f035d4ff5d6449b134d83c.jpg&ehk=JMh93EGZ0f0RDvII6SRwXeB2KzrZoAQpglqCYuq7ryk%3d&risl=&pid=ImgRaw&r=0', // Evento
    ),
    FeedPost(
      id: 4,
      autor: 'Ana Paula',
      conteudo: 'Quando será a próxima campanha de vacinação?',
      data: DateTime.now().subtract(const Duration(days: 3)),
      comentarios: [],
      imagemUrl:
          'https://cdn.pixabay.com/photo/2016/02/22/11/20/vaccination-1215279_1280.jpg', // Vacinação
    ),
    FeedPost(
      id: 5,
      autor: 'Roberto Torres',
      conteudo: 'A rua está com buracos, precisa de recapeamento.',
      data: DateTime.now().subtract(const Duration(days: 4)),
      comentarios: [],
      imagemUrl:
          'https://doutormultas.com.br/wp-content/uploads/2017/09/buraco-na-rua-dicas-como-lidar-ruas-esburacadas.jpg', // Obras
    ),
  ];

  FeedPost? postSelecionado;
  bool mostrarComentarios = false;
  final TextEditingController respostaController = TextEditingController();
  String responderComo = 'Prefeitura';
  final List<String> opcoesResposta = [
    'Prefeitura',
    'Secretaria de Obras',
    'Secretaria de Saúde',
    'Secretaria de Educação',
  ];

  void selecionarPost(FeedPost post) {
    postSelecionado = post;
    mostrarComentarios = true;
    update();
  }

  void fecharComentarios() {
    postSelecionado = null;
    mostrarComentarios = false;
    respostaController.clear();
    update();
  }

  void responderComentario() {
    if (postSelecionado != null && respostaController.text.isNotEmpty) {
      postSelecionado!.comentarios.add(
        FeedComment(
          id: postSelecionado!.comentarios.length + 1,
          autor: responderComo,
          conteudo: respostaController.text,
          data: DateTime.now(),
        ),
      );
      respostaController.clear();
      update();
    }
  }

  void bloquearOuDesbloquearPost(FeedPost post) {
    post.bloqueado = !post.bloqueado;
    update();
  }
}
