import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:nukegame/types/slot_state.dart';

part 'json_slot.g.dart';

@JsonSerializable(explicitToJson: true)
class JsonSlot {
  final String id;
  final String owner;
  final bool hidden;
  final SlotState state;

  const JsonSlot({
    this.id = '',
    this.owner = '',
    this.hidden = false,
    this.state = SlotState.empty,
  });

  factory JsonSlot.fromString(String json) => JsonSlot.fromJson(jsonDecode(json));

  factory JsonSlot.fromJson(Map<String, dynamic> json) => _$JsonSlotFromJson(json);

  Map<String, dynamic> toJson() => _$JsonSlotToJson(this);
}
