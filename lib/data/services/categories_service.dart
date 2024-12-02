import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';

class CategoriesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Category>> fetchCategories() async {
    final querySnapshot = await _firestore.collection('categories').get();
    return querySnapshot.docs
        .map((doc) => Category.fromMap(doc.data()))
        .toList();
  }
}
