class DataCustModel {
  String? name;
  String? cKdC;
  int? nBrutto;

  DataCustModel({
    this.name,
    this.cKdC,
    this.nBrutto,
});

  factory DataCustModel.fromJson(Map<String, dynamic> json) {
    return DataCustModel(
      name: json['cNmC'] ?? '-',
      cKdC: json['cKdC'],
      nBrutto: _parseFormattedNumber(json['nBrutto']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cNmC': name,
      'cKdC': cKdC,
      'nBrutto': nBrutto,
    };
  }
}

int? _parseFormattedNumber(dynamic value) {
  if (value == null) return null;
  final cleaned = value.toString().replaceAll(',', '').split('.').first;
  return int.tryParse(cleaned);
}