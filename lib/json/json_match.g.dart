// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMatch _$JsonMatchFromJson(Map<String, dynamic> json) => JsonMatch(
      id: json['id'] as String? ?? '',
      players: (json['players'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      slots: (json['slots'] as List<dynamic>?)?.map((e) => JsonSlot.fromJson(e as Map<String, dynamic>)).toList() ?? const [],
    );

Map<String, dynamic> _$JsonMatchToJson(JsonMatch instance) => <String, dynamic>{
      'id': instance.id,
      'players': instance.players,
      'slots': instance.slots.map((e) => e.toJson()).toList(),
    };
