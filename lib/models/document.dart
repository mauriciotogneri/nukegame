import 'package:cloud_firestore/cloud_firestore.dart';

class Document {
  final String docId;
  final Map<String, dynamic> _data;

  const Document._(this.docId, this._data);

  List<String> get fieldNames => _data.keys.toList();

  factory Document.load(DocumentSnapshot doc) => Document._(
        doc.id,
        doc.data() as Map<String, dynamic>,
      );

  factory Document.fromMap(Map<String, dynamic> map) => Document._('', map);

  String? getString(String field, [String? defaultValue]) => _get<String>(field, defaultValue);

  List<dynamic>? getList(String field, [List<dynamic> defaultValue = const []]) => _get<List<dynamic>>(field, defaultValue);

  num? getNumber(String field, [num? defaultValue]) => _get<num>(field, defaultValue);

  bool? getBool(String field, [bool? defaultValue]) => _get<bool>(field, defaultValue);

  Document getDocument(String field) => Document.fromMap(_get<Map<String, dynamic>>(field, {}) ?? {});

  Timestamp? getTimestamp(String field, [Timestamp? defaultValue]) => _get<Timestamp>(field, defaultValue);

  DateTime? getDateTime(String field, [DateTime? defaultValue]) {
    final Timestamp? value = getTimestamp(field, null);

    return (value != null) ? DateTime.fromMillisecondsSinceEpoch(value.millisecondsSinceEpoch) : defaultValue;
  }

  bool contains(String field) => _get<dynamic>(field, null) != null;

  T? _get<T>(String field, T? defaultValue) {
    try {
      final List<String> fields = field.split('.');
      dynamic result = _data;

      for (final String fieldName in fields) {
        result = result[fieldName];
      }

      return result as T;
    } catch (e) {
      return defaultValue;
    }
  }
}
