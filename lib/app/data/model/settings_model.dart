// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 1)
class SettingsModel {
  @HiveField(0)
  final int position;
  @HiveField(1)
  final bool runAtStartUp;
  SettingsModel({
    required this.position,
    required this.runAtStartUp,
  });

  SettingsModel copyWith({
    int? position,
    bool? runAtStartUp,
  }) {
    return SettingsModel(
      position: position ?? this.position,
      runAtStartUp: runAtStartUp ?? this.runAtStartUp,
    );
  }

  @override
  bool operator ==(covariant SettingsModel other) {
    if (identical(this, other)) return true;

    return other.position == position && other.runAtStartUp == runAtStartUp;
  }

  @override
  int get hashCode => position.hashCode ^ runAtStartUp.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'position': position,
      'runAtStartUp': runAtStartUp,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      position: map['position'] as int,
      runAtStartUp: map['runAtStartUp'] as bool,
    );
  }
}
