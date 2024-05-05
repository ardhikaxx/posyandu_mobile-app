// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      noKk: json['noKk'] as String,
      nikIbu: json['nikIbu'] as String,
      namaIbu: json['namaIbu'] as String,
      tempatLahirIbu: json['tempatLahirIbu'] as String,
      tanggalLahirIbu: json['tanggalLahirIbu'] as String,
      golDarahIbu: json['golDarahIbu'] as String,
      nikAyah: json['nikAyah'] as String,
      namaAyah: json['namaAyah'] as String,
      alamat: json['alamat'] as String,
      telepon: (json['telepon'] as num).toInt(),
      emailOrangTua: json['emailOrangTua'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'noKk': instance.noKk,
      'nikIbu': instance.nikIbu,
      'namaIbu': instance.namaIbu,
      'tempatLahirIbu': instance.tempatLahirIbu,
      'tanggalLahirIbu': instance.tanggalLahirIbu,
      'golDarahIbu': instance.golDarahIbu,
      'nikAyah': instance.nikAyah,
      'namaAyah': instance.namaAyah,
      'alamat': instance.alamat,
      'telepon': instance.telepon,
      'emailOrangTua': instance.emailOrangTua,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
