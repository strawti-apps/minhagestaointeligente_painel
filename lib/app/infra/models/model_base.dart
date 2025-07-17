/// Base para modelos que serão convertidos para JSON com segurança para campos nulos.
/// Usado para evitar enviar campos ID nulos para o banco de dados que são auto-incrementais.
abstract class ModelBase {
  /// Converte o modelo para um mapa, omitindo campos nulos
  /// que não devem ser enviados ao banco de dados.
  Map<String, dynamic> toMap();

  /// Utilitário para criar um mapa seguro, que remove chaves com valores nulos
  Map<String, dynamic> createMap() {
    return <String, dynamic>{};
  }
  
  /// Adiciona um campo ao mapa apenas se não for nulo
  void addIfNotNull(Map<String, dynamic> map, String key, dynamic value) {
    if (value != null) {
      map[key] = value;
    }
  }
  
  /// Adiciona um campo DateTime ao mapa apenas se não for nulo
  void addDateTimeIfNotNull(Map<String, dynamic> map, String key, DateTime? value) {
    if (value != null) {
      map[key] = value.toIso8601String();
    }
  }

  void addListIfNotEmpty<T>(Map<String, dynamic> map, String key, List<T>? list) {
    if (list != null && list.isNotEmpty) {
      map[key] = list;
    }
  }

  void addMapIfNotEmpty(Map<String, dynamic> map, String key, Map<String, dynamic>? value) {
    if (value != null && value.isNotEmpty) {
      map[key] = value;
    }
  }
} 