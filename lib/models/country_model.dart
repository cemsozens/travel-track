class CountryModel {
  final String code;
  final String name;
  final DateTime? visitedDate;
  
  CountryModel({
    required this.code,
    required this.name,
    this.visitedDate,
  });
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountryModel && other.code == code;
  }
  
  @override
  int get hashCode => code.hashCode;
  
  @override
  String toString() {
    return 'CountryModel(code: $code, name: $name, visitedDate: $visitedDate)';
  }
} 