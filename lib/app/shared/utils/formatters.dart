import 'package:intl/intl.dart';
import 'dart:math' as math;

class Formatters {
  static String formatDate(DateTime? date, {String format = 'dd/MM/yyyy'}) {
    if (date == null) return '-';
    return DateFormat(format).format(date);
  }

  static String formatDateTime(DateTime? date, {String format = 'dd/MM/yyyy HH:mm'}) {
    if (date == null) return '-';
    return DateFormat(format).format(date);
  }

  static String formatTime(DateTime? date, {String format = 'HH:mm'}) {
    if (date == null) return '-';
    return DateFormat(format).format(date);
  }

  static String formatCurrency(double? value, {String symbol = 'R\$', int decimalDigits = 2}) {
    if (value == null) return '-';
    final formatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(value);
  }

  static String formatRelativeTime(DateTime? date) {
    if (date == null) return '-';
    
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 7) {
      return formatDate(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'dia' : 'dias'} atrás';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hora' : 'horas'} atrás';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minuto' : 'minutos'} atrás';
    } else {
      return 'Agora';
    }
  }

  static String formatBytes(int bytes, {int decimals = 2}) {
    if (bytes <= 0) return '0 B';
    
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (math.log(bytes) / math.log(1024)).floor();
    
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
  
  static String truncateText(String? text, int maxLength) {
    if (text == null || text.isEmpty) return '';
    if (text.length <= maxLength) return text;
    
    return '${text.substring(0, maxLength)}...';
  }
  
  static String capitalize(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }
  
  static String? getInitials(String? name, {int maxInitials = 2}) {
    if (name == null || name.isEmpty) return null;
    
    final nameParts = name.trim().split(' ');
    final initials = StringBuffer();
    
    for (var i = 0; i < nameParts.length && i < maxInitials; i++) {
      if (nameParts[i].isNotEmpty) {
        initials.write(nameParts[i][0].toUpperCase());
      }
    }
    
    return initials.toString();
  }
} 