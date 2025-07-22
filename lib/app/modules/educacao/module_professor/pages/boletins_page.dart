import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/boletins_controller.dart';

class BoletinsPage extends StatelessWidget {
  static const route = '/professor/boletins';
  const BoletinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BoletinsController());
    return Scaffold(
      appBar: AppBar(title: const Text('Boletins')),
      body: ListView.builder(
        itemCount: controller.boletins.length,
        itemBuilder: (context, index) {
          final boletim = controller.boletins[index];
          return ListTile(
            leading: const Icon(Icons.assignment),
            title: Text(boletim['aluno'] ?? ''),
            subtitle: Text('Nota: ${boletim['nota'] ?? ''}'),
          );
        },
      ),
    );
  }
}
