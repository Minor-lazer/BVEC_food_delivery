import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/bloc/listTileColorBloc.dart';
import 'bloc/cartlistBloc.dart';
import 'cart.dart';
import 'const/themeColor.dart';
import 'model/food_item.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        //add yours BLoCs controlles
        Bloc((i) => CartListBloc()),
        Bloc((i) => ColorBloc()),
            ],
      child: MaterialApp(
        title: "BVEC FoodTruck",
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Home extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: ListView(
          children: <Widget>[
            FirstHalf(),
            SizedBox(height: 15),
            for (var foodItem in fooditemList.foodItems)
              Builder(
                builder: (context) 
                {
                  return ItemContainer(foodItem: foodItem);
                },
              )
          ],
        ),
      )),
    );
  }
}

class ItemContainer extends StatelessWidget {
  
  ItemContainer({
    @required this.foodItem,
  });

  final FoodItem foodItem;
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  
  addToCart(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  removeFromList(FoodItem foodItem) {
    bloc.removeFromList(foodItem);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(foodItem);
        final snackBar = SnackBar(
          content: Text('${foodItem.title} added to Cart'),
          duration: Duration(milliseconds: 550),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Items(
        hotel: foodItem.hotel,
        itemName: foodItem.title,
        itemPrice: foodItem.price,
        itemImage: foodItem.image,
        leftAligned: (foodItem.id % 2) == 0 ? true : false,
      ),
    );
  }
}

class FirstHalf extends StatelessWidget {
  const FirstHalf( 
    {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          //you could also use the spacer widget to give uneven distances, i just decided to go with a sizebox
          SizedBox(height: 30),
          title(),
          SizedBox(height: 30),
          searchBar(),
          SizedBox(height: 45),
          categories(),
        ],
      ),
    );
  }
}

Widget categories() {
  return Container(
    height: 185,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        CategoryListItem(
          categoryIcon:Icons.fastfood,
          categoryName: 'Biryani',
          availability: 12,
          selected: true,
        ),
        CategoryListItem(
          categoryIcon:Icons.fastfood,
          categoryName: "butter chicken",
          availability: 1,
          selected: false,
        ),
        CategoryListItem(
          categoryIcon:Icons.fastfood,
          categoryName: "chilly chicken",
          availability: 1,
          selected: false,
        ),
        CategoryListItem(
          categoryIcon:Icons.fastfood,
          categoryName: "Burgers",
          availability: 1,
          selected: false,
        ),
        CategoryListItem(
          categoryIcon:Icons.fastfood,
          categoryName: "Burgers",
          availability: 1,
          selected: false,
        ),
      ],
    ),
  );
}

class Items extends StatelessWidget {
  Items({
    @required this.leftAligned,
    @required this.itemImage,
    @required this.itemName,
    @required this.itemPrice,
    @required this.hotel,
  });

  final bool leftAligned;
  final Image itemImage;
  final String itemName;
  final double itemPrice;
  final String hotel;

  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
             boxShadow:[
BoxShadow(
  color: Colors.black.withOpacity(.1),
  blurRadius: 4.0,
  offset: Offset(1, 1),
  spreadRadius: 4.0
),

                    ]
          ),
          padding: EdgeInsets.only(
            left: leftAligned ? 0 : containerPadding,
            right: leftAligned ? containerPadding : 0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    ),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned
                        ? Radius.circular(0)
                        : Radius.circular(containerBorderRadius),
                    right: leftAligned
                        ? Radius.circular(containerBorderRadius)
                        : Radius.circular(0),
                  ),
                  child: itemImage,//Food Item Image
                ),
              ),
              SizedBox(height: 20),
              Container(
                  padding: EdgeInsets.only(
                    left: leftAligned ? 20 : 0,
                    right: leftAligned ? 0 : 20,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(itemName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  )),
                            ),
                            Text("\$$itemPrice",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                )),
                          ],
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 15),
                                children: [
                                  TextSpan(text: "by "),
                                  TextSpan(
                                      text: hotel,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700))
                                        ]
                                ),
                          ),
                        ),
                        SizedBox(height: containerPadding),
                      ])),
            ],
          ),
        )
      ],
    );
  }
}

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    Key key,
    @required this.categoryIcon,
    @required this.categoryName,
    @required this.availability,
    @required this.selected,
  }) : super(key: key);

  final IconData categoryIcon;
  final String categoryName;
  final int availability;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
     
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(5, 10, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: selected ? Themes.color : Colors.white,
        border: Border.all(
            color: selected ? Colors.orangeAccent.shade100 : Colors.grey[200],
            width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            blurRadius: 15,
            offset: Offset(0, 0),
            spreadRadius: 5,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: selected?Colors.orangeAccent:Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: selected ? Colors.orangeAccent : Colors.grey[200],
                    width: 1.5)),
              child: IconButton(onPressed: null, icon:Icon(categoryIcon,color: selected?Colors.white:Colors.grey),) //Added Category Icon
              
          ),
          SizedBox(height: 10),
          Text(
            categoryName,
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black, fontSize: 15),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 6, 0, 10),
            width: 1.5,
            height: 15,
            color: Colors.black26,
          ),
          Text(
            availability.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

Widget searchBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Icon(
        Icons.search,
        color: Colors.black45,
      ),
      SizedBox(width: 20),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
              hintText: "Search....",
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintStyle: TextStyle(
                color: Colors.black87,
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red))),
        ),
      ),
    ],
  );
}

Widget title() {
  
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      // SizedBox(width: 45),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container( 
           
            child:Center(
             
              child: new Image.asset(
                'icons/food.png',
                width: 100,
                height: 100,
                fit:BoxFit.fill  ),
            ),

          )
          

        
        ],
      ),
    ],
  );
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu),
          StreamBuilder(
            stream: bloc.listStream,
            builder: (context, snapshot) {
              List<FoodItem> foodItems = snapshot.data;
              int length = foodItems != null ? foodItems.length : 0;

              return buildGestureDetector(length, context, foodItems);
            },
          )
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(
      int length, BuildContext context, List<FoodItem> foodItems) {
    return GestureDetector(
      onTap: () {
        if (length > 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Cart()));
        } else {
          return;
        }
      },
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.only(right: 30),
        child: Center(child: Text(length.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20),)),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.yellow[800], borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}