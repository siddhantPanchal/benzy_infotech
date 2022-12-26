import 'dart:convert';

class EnumValues<T> {
  final Map<String, T> map;
  Map<T, String>? reverseMap = {};

  EnumValues({required this.map});

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}


enum Breakfast {
  canceled,
  pending,
  delivered,
}




final breakfastValues = EnumValues(map: {
  "Canceled": Breakfast.canceled,
  "Delivered": Breakfast.delivered,
  "Pending": Breakfast.pending
});

class OptInsClass {
  OptInsClass({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  final Breakfast breakfast;
  final Breakfast lunch;
  final Breakfast dinner;

  factory OptInsClass.fromJson(String str) =>
      OptInsClass.fromMap(json.decode(str));

  factory OptInsClass.fromMap(Map<String, dynamic> json) => OptInsClass(
        breakfast: breakfastValues.map[json["breakfast"]]!,
        lunch: breakfastValues.map[json["lunch"]]!,
        dinner: breakfastValues.map[json["dinner"]]!,
      );

  OptInsClass copyWith({
    Breakfast? breakfast,
    Breakfast? lunch,
    Breakfast? dinner,
  }) {
    return OptInsClass(
      breakfast: breakfast ?? this.breakfast,
      lunch: lunch ?? this.lunch,
      dinner: dinner ?? this.dinner,
    );
  }

  @override
  String toString() =>
      'OptInsClass(breakfast: $breakfast, lunch: $lunch, dinner: $dinner)';

  @override
  bool operator ==(covariant OptInsClass other) {
    if (identical(this, other)) return true;

    return other.breakfast == breakfast &&
        other.lunch == lunch &&
        other.dinner == dinner;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      breakfast,
      lunch,
      dinner,
    ]);
  }
}
