import 'package:flutter/foundation.dart';

class Album with ChangeNotifier {
  int id;
  String cover;
  String name;

  Album(this.id, this.cover, this.name);
}
