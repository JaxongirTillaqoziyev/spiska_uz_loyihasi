import 'package:flutter/cupertino.dart';

class LikeVM extends ChangeNotifier {
  bool isLiked = false;

  void pressLike() {
    isLiked = !isLiked;
    notifyListeners();
  }
}
