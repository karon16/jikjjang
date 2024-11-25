class Category {
  final String categoryID;
  final String name;
  final String description;

  Category({
    required this.categoryID,
    required this.name,
    required this.description,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryID: map['categoryID'],
      name: map['name'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryID': categoryID,
      'name': name,
      'description': description,
    };
  }
}
