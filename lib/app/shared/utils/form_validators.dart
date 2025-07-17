class FormValidators {
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Digite um endereço de e-mail válido';
    }
    
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    
    return null;
  }
  
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    if (value != password) {
      return 'As senhas não coincidem';
    }
    
    return null;
  }
  
  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL é opcional
    }
    
    final urlRegex = RegExp(
      r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    
    if (!urlRegex.hasMatch(value)) {
      return 'Digite uma URL válida';
    }
    
    return null;
  }
  
  static String? minLength(String? value, int minLength) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    if (value.length < minLength) {
      return 'Este campo deve ter pelo menos $minLength caracteres';
    }
    
    return null;
  }
  
  static String? maxLength(String? value, int maxLength) {
    if (value == null || value.isEmpty) {
      return null; // Opcional
    }
    
    if (value.length > maxLength) {
      return 'Este campo deve ter no máximo $maxLength caracteres';
    }
    
    return null;
  }
  
  static String? integer(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    if (int.tryParse(value) == null) {
      return 'Digite um número inteiro válido';
    }
    
    return null;
  }
  
  static String? positiveInteger(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    final intValue = int.tryParse(value);
    if (intValue == null) {
      return 'Digite um número inteiro válido';
    }
    
    if (intValue <= 0) {
      return 'O valor deve ser maior que zero';
    }
    
    return null;
  }
  
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    if (value.length < 2) {
      return 'Digite um nome válido';
    }
    
    return null;
  }
  
  static String? Function(String?) compose(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }
} 