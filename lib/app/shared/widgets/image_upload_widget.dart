import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../utils/app_snackbar.dart';

class ImageUploadWidget extends StatefulWidget {
  final String? initialImageUrl;
  final Function(dynamic) onImageChanged;
  final bool isUploading;
  final String title;
  final String hintText;
  final String? currentImageUrl; // Nova propriedade para URL atual

  const ImageUploadWidget({
    super.key,
    this.initialImageUrl,
    required this.onImageChanged,
    this.isUploading = false,
    this.title = 'Imagem',
    this.hintText = 'Selecione uma imagem',
    this.currentImageUrl,
  });

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  String? _selectedImageUrl;
  String? _selectedFileName;

  @override
  void initState() {
    super.initState();
    _selectedImageUrl = widget.initialImageUrl ?? widget.currentImageUrl;
  }

  @override
  void didUpdateWidget(ImageUploadWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Atualiza a URL quando o widget pai muda
    if (widget.currentImageUrl != oldWidget.currentImageUrl) {
      setState(() {
        _selectedImageUrl = widget.currentImageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primaryDark.withValues(alpha: 0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[50],
          ),
          child: widget.isUploading
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        'Enviando imagem...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : _selectedImageUrl != null
                  ? _buildImagePreview()
                  : _buildUploadArea(),
        ),
        
        if (_selectedFileName != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Arquivo: $_selectedFileName',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            _selectedImageUrl!,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.broken_image,
                      size: 48,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Erro ao carregar imagem',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  onPressed: widget.isUploading ? null : () => _selectImage(),
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                  tooltip: 'Alterar imagem',
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  onPressed: widget.isUploading ? null : () => _removeImage(),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 20,
                  ),
                  tooltip: 'Remover imagem',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadArea() {
    return InkWell(
      onTap: widget.isUploading ? null : () => _selectImage(),
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 48,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 16),
            Text(
              widget.hintText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              kIsWeb 
                  ? 'Clique ou arraste uma imagem aqui'
                  : 'Toque para abrir a galeria',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryDark.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'JPG, PNG, WebP (até 50MB)',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: kIsWeb, // Para web, carrega os bytes
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        
        setState(() {
          _selectedFileName = file.name;
        });

        // Chama o callback com o arquivo para upload
        if (kIsWeb) {
          if (file.bytes != null) {
            widget.onImageChanged(file.bytes);
          }
        } else {
          if (file.path != null) {
            widget.onImageChanged(file.path);
          }
        }
      }
    } catch (e) {
      debugPrint('Erro ao selecionar imagem: $e');
      AppSnackbar.to.error('Erro ao selecionar imagem: $e');
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImageUrl = null;
      _selectedFileName = null;
    });
    widget.onImageChanged(null);
  }

  void updateImageUrl(String? url) {
    setState(() {
      _selectedImageUrl = url;
    });
  }
} 