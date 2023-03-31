dynamic removeNull(dynamic params) {
  final h = [null, ''];
  if (params is Map) {
    final map = <dynamic, dynamic>{};
    params.forEach((key, value) {
      final val = removeNull(value);
      var v = val;
      if (val is String) {
        v = val.trim();
      }
      var bool = false;
      for (final e in h) {
        final a = bool;
        final b = v == e;
        bool = a || b;
      }
      if (!bool) {
        map[key] = val;
      }
    });
    // comment this condition if you want empty dictionary
    if (map.isNotEmpty) {
      return map;
    }
  } else if (params is List) {
    final list = <dynamic>[];
    for (final value in params) {
      final val = removeNull(value);
      var v = val;
      if (val is String) {
        v = val.trim();
      }
      var bool = false;
      for (final e in h) {
        final a = bool;
        final b = v == e;
        bool = a || b;
      }
      if (!bool) {
        list.add(val);
      }
    }
    // comment this condition if you want empty list
    if (list.isNotEmpty) {
      return list;
    }
  } else if (params != null) {
    return params;
  }
  return null;
}

// Map<dynamic, dynamic> removeNullsFromMap(Map<dynamic, dynamic> json) => json
//   ..removeWhere((key, value) => value == null)
//   ..map<String, dynamic>((key, value) => MapEntry(key, removeNulls(value)));

// List removeNullsFromList(List list) => list
//   ..removeWhere((value) => value == null)
//   ..map((e) => removeNulls(e)).toList();

// removeNulls(e) => (e is List)
//     ? removeNullsFromList(e)
//     : (e is Map ? removeNullsFromMap(e) : e);

extension ListExtension on List<dynamic> {
  // List removeNulls() => removeNullsFromList(this);
  dynamic removeNulls() => removeNull(this);
}

extension MapExtension on Map<dynamic, dynamic> {
  // Map removeNulls() => removeNullsFromMap(this);
  dynamic removeNulls() => removeNull(this);
}

typedef JsonMap = Map<String, dynamic>;

extension JsonMapX on JsonMap {
  void removeIfEmpty(Iterable<String> keys) {
    for (final key in keys) {
      if (this[key] == '') {
        remove(key);
      }
    }
  }
}
