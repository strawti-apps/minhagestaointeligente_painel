import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScreenshotService {
  /// Captura um widget como imagem e faz download
  static Future<void> captureWidget(GlobalKey key, String filename) async {
    try {
      // Captura o widget usando RepaintBoundary
      final RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 4.0);

      // Converte para bytes
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List bytes = byteData!.buffer.asUint8List();

      // Converte para base64
      final String base64Image = base64Encode(bytes);

      // Cria link de download
      final html.AnchorElement anchor = html.AnchorElement(
        href: 'data:image/png;base64,$base64Image',
      );
      anchor.download = filename;
      anchor.click();
    } catch (e) {
      debugPrint('Erro ao capturar screenshot: $e');
      rethrow;
    }
  }

  /// Captura widget e abre em nova aba
  static Future<void> captureAndOpenInNewTab(GlobalKey key) async {
    try {
      final RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 4.0);

      // Converte para bytes
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List bytes = byteData!.buffer.asUint8List();

      // Converte para base64
      final String base64Image = base64Encode(bytes);

      // Abre em nova aba
      final String dataUrl = 'data:image/png;base64,$base64Image';
      html.window.open(dataUrl, '_blank');
    } catch (e) {
      debugPrint('Erro ao abrir screenshot em nova aba: $e');
      rethrow;
    }
  }
}
