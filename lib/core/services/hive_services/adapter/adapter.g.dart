// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapter.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class FavoriteAdapter extends TypeAdapter<Favorite> {
  @override
  final typeId = 0;

  @override
  Favorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favorite(
      id: fields[0] as String,
      productCode: fields[1] as String?,
      name: fields[2] as String,
      description: fields[3] as String?,
      arabicName: fields[4] as String?,
      arabicDescription: fields[5] as String?,
      coverPictureUrl: fields[6] as String?,
      productPictures: fields[7] == null
          ? const []
          : (fields[7] as List).cast<String>(),
      price: (fields[8] as num).toDouble(),
      stock: (fields[9] as num).toInt(),
      weight: (fields[10] as num?)?.toDouble(),
      color: fields[11] as String?,
      rating: (fields[12] as num).toDouble(),
      reviewsCount: (fields[13] as num).toInt(),
      discountPercentage: (fields[14] as num).toInt(),
      sellerId: fields[15] as String?,
      categories: fields[16] == null
          ? const []
          : (fields[16] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Favorite obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productCode)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.arabicName)
      ..writeByte(5)
      ..write(obj.arabicDescription)
      ..writeByte(6)
      ..write(obj.coverPictureUrl)
      ..writeByte(7)
      ..write(obj.productPictures)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.stock)
      ..writeByte(10)
      ..write(obj.weight)
      ..writeByte(11)
      ..write(obj.color)
      ..writeByte(12)
      ..write(obj.rating)
      ..writeByte(13)
      ..write(obj.reviewsCount)
      ..writeByte(14)
      ..write(obj.discountPercentage)
      ..writeByte(15)
      ..write(obj.sellerId)
      ..writeByte(16)
      ..write(obj.categories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
