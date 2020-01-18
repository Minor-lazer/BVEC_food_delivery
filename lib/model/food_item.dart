import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FoodItem {
  int id;
  String title;
  String hotel;
  double price;
  Image image;
  int quantity;

  FoodItem({
    @required this.id,
    @required this.title,
    @required this.hotel,
    @required this.price,
    @required this.image,
    this.quantity = 1,
  });

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() 
  {
    this.quantity = this.quantity - 1;
  }
}

class FooditemList 
{
  List<FoodItem> foodItems;

  FooditemList({@required this.foodItems});
}

FooditemList fooditemList = FooditemList(foodItems: [
  FoodItem
  (
    id: 1,
    title: "Chicken Biryani",
    hotel: "Khan Biryani,Badarpur",
    price: 14.49,
    image:Image.asset('icons/biriyani.jpg',fit: BoxFit.fill),
        
  ),//,
  FoodItem
  (
    id: 2,
    title: "Chilly chicken",
    hotel: "Chandan",
    price: 11.99,
    image:Image.asset('icons/chillychicken.jpg',fit: BoxFit.fill),
    
  ),
  FoodItem(
    id: 3,
    title: "Butter Chicken",
    hotel: "Sonakshi",
    price: 8.49,
    image:Image.asset('icons/chicken.png',fit: BoxFit.fill),
  ),
  FoodItem(
    id: 4,
    title: "Chilly Cheeze Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
   image:Image.asset('icons/burger.png',fit: BoxFit.fill),
  ),
  FoodItem
  (
    id: 5,
    title: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    image:Image.asset('icons/burger.png',fit: BoxFit.fill),
  ),
  FoodItem
  (
    id: 6,
    title: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    image:Image.asset('icons/burger.png',fit: BoxFit.fill),
  ),
]);
