// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonSlot _$JsonSlotFromJson(Map<String, dynamic> json) => JsonSlot(
      id: json['id'] as String? ?? '',
      owner: json['owner'] as String? ?? '',
      hidden: json['hidden'] as bool? ?? false,
      state: $enumDecodeNullable(_$SlotStateEnumMap, json['state']) ?? SlotState.empty,
    );

Map<String, dynamic> _$JsonSlotToJson(JsonSlot instance) => <String, dynamic>{
      'id': instance.id,
      'owner': instance.owner,
      'hidden': instance.hidden,
      'state': _$SlotStateEnumMap[instance.state]!,
    };

const _$SlotStateEnumMap = {
  SlotState.empty: 'empty',
  SlotState.base: 'base',
  SlotState.destroyed: 'destroyed',
};
