class Category {
  final String icon;
  final String categoryID;
  final String name;
  final String description;

  Category({
    required this.icon,
    required this.categoryID,
    required this.name,
    required this.description,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    if (map['name'] == null || map['name'].isEmpty) {
      throw ArgumentError('Category name is required');
    }
    return Category(
      icon: map['icon'] ?? '',
      categoryID: map['categoryID'] ?? '',
      name: map['name'],
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': icon,
      'categoryID': categoryID,
      'name': name,
      'description': description,
    };
  }
}
