class Person {
  final String name;
  final int age;
  final double height;

//<editor-fold desc="Data Methods">
  const Person({
    required this.name,
    required this.age,
    required this.height,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Person &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          age == other.age &&
          height == other.height);

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ height.hashCode;

  @override
  String toString() {
    return 'Person{ name: $name, age: $age, height: $height,}';
  }

  Person copyWith({
    String? name,
    int? age,
    double? height,
  }) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      height: height ?? this.height,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'height': height,
    };
  }

  factory Person.fromJson(Map<String, dynamic> map) {
    return Person(
      name: map['name'] as String,
      age: map['age'] as int,
      height: map['height'] as double,
    );
  }

//</editor-fold>
}
