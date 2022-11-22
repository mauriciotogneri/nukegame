// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_input_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonInputMessage _$JsonInputMessageFromJson(Map<String, dynamic> json) => JsonInputMessage(
      playerName: json['playerName'] as String?,
      matchId: json['matchId'] as String?,
      laneId: json['laneId'] as int?,
      amount: json['amount'] as int?,
      direction: json['direction'] as int?,
      attackLevel: json['attackLevel'] as int?,
      finishState: $enumDecodeNullable(_$FinishStateEnumMap, json['finishState']),
    );

Map<String, dynamic> _$JsonInputMessageToJson(JsonInputMessage instance) => <String, dynamic>{
      'playerName': instance.playerName,
      'matchId': instance.matchId,
      'laneId': instance.laneId,
      'amount': instance.amount,
      'direction': instance.direction,
      'attackLevel': instance.attackLevel,
      'finishState': _$FinishStateEnumMap[instance.finishState],
    };

const _$FinishStateEnumMap = {
  FinishState.WON: 'WON',
  FinishState.LOST: 'LOST',
  FinishState.TIE: 'TIE',
};
