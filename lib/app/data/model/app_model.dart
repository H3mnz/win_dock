// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'app_model.g.dart';

@HiveType(typeId: 0)
class AppModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String path;
  @HiveField(2)
  final Uint8List? icon;
  AppModel({
    required this.name,
    required this.path,
    this.icon,
  });

  AppModel copyWith({
    String? name,
    String? path,
    Uint8List? icon,
  }) {
    return AppModel(
      name: name ?? this.name,
      path: path ?? this.path,
      icon: icon ?? this.icon,
    );
  }

  @override
  bool operator ==(covariant AppModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.path == path && listEquals(other.icon, icon);
  }

  @override
  int get hashCode => name.hashCode ^ path.hashCode ^ icon.hashCode;
}
