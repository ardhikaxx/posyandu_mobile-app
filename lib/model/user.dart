import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserData {
  final int noKk;
  final String nikIbu;
  final String namaIbu;
  final String tempatLahirIbu;
  final String tanggalLahirIbu;
  final String golDarahIbu;
  final String nikAyah;
  final String namaAyah;
  final String alamat;
  final String telepon;
  final String emailOrangTua;
  final String createdAt;
  final String updatedAt;

  UserData({
    required this.noKk,
    required this.nikIbu,
    required this.namaIbu,
    required this.tempatLahirIbu,
    required this.tanggalLahirIbu,
    required this.golDarahIbu,
    required this.nikAyah,
    required this.namaAyah,
    required this.alamat,
    required this.telepon,
    required this.emailOrangTua,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}