import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/material_escolar_controller.dart';

class MaterialEscolarPage extends StatelessWidget {
  static const route = '/professor/material_escolar';
  const MaterialEscolarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MaterialEscolarController());
    return Scaffold(
      appBar: AppBar(title: const Text('Material Escolar')),
      body: ListView.builder(
        itemCount: controller.materiais.length,
        itemBuilder: (context, index) {
          final material = controller.materiais[index];
          return ListTile(
            leading: const Icon(Icons.menu_book),
            title: Text(material['nome'] as String? ?? ''),
            subtitle: Text('Quantidade: ${material['quantidade'].toString()}'),
          );
        },
      ),
    );
  }
}
