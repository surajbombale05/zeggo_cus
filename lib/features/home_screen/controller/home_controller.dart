import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  var categories = [
    {"name": "Vegetables", "icon": "🥦"},
    {"name": "Fruits", "icon": "🍎"},
    {"name": "Grocery", "icon": "🛒"},
    {"name": "Food", "icon": "🍔"},
  ].obs;

  var products = [
    {
      "name": "Tomato",
      "price": 40,
      "image": "https://via.placeholder.com/150"
    },
    {
      "name": "Apple",
      "price": 120,
      "image": "https://via.placeholder.com/150"
    },
    {
      "name": "Milk",
      "price": 55,
      "image": "https://via.placeholder.com/150"
    },
  ].obs;
}
