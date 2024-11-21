import 'package:flutter_riverpod/flutter_riverpod.dart';

// Holds the current route or page
final navigationIndexProvider = StateProvider<int>((ref) => 0);

