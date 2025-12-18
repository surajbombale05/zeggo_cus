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
    "name": "Fresh Banana",
    "price": 40,
    "discount": 20,
    "qty": 0.obs,
  },
  {
    "name": "Apple Red",
    "price": 120,
    "discount": 15,
    "qty": 0.obs,
  },
].obs;

// void addItem(int i) {
//   products[i]["qty"].value++;
// }

// void removeItem(int i) {
//   if (products[i]["qty"].value > 0) {
//     products[i]["qty"].value--;
//   }
// }

}
