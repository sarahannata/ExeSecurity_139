import 'dart:convert';

class Restoran {
  final String nama;
  final String lokasi;

  Restoran({
    required this.nama,
    required this.lokasi,
  });

  Restoran copyWith({
    String? nama,
    String? lokasi,
  }) {
    return Restoran(
      nama: nama ?? this.nama,
      lokasi: lokasi ?? this.lokasi,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'lokasi': lokasi,
    };
  }

  factory Restoran.fromMap(Map<String, dynamic> map) {
    return Restoran(
      nama: map['nama'] as String,
      lokasi: map['lokasi'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Restoran.fromJson(String source) =>
      Restoran.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Kontak(nama: $nama, lokasi: $lokasi)';
  }

  @override
  bool operator ==(covariant Restoran other) {
    if (identical(this, other)) return true;

    return other.nama == nama && other.lokasi == lokasi;
  }

  @override
  int get hashCode {
    return nama.hashCode ^ lokasi.hashCode;
  }
}
