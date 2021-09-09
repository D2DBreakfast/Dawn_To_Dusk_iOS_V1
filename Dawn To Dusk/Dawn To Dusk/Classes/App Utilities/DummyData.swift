//
//  DummyData.swift
//  Dawn To Dusk
//
//  Created by Hiren on 29/07/21.
//

import Foundation
import SwiftyJSON


func dummyIMG() -> String? {
    return "https://source.unsplash.com/random/200x200"
}

func randomID(digits:Int) -> Int {
    let min = Int(pow(Double(10), Double(digits-1))) - 1
    return min
}

func randomString(length: Int? = Int.random(in: 11..<9999)) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length!).map{ _ in letters.randomElement()! })
}

func dummygallery() -> [String] {
    var gallery: [String]! = []
    for _ in 0...5 {
        gallery.append(dummyIMG()!)
    }
    return gallery
}

func DummyPrice() -> Double? {
    return Double.init(Int.random(in: 10..<99))
}

func DummyVeg_non() -> Bool? {
    let ids = Int.random(in: 0..<2)
    if ids == 0 {
        return false
    }
    return true
}

func DummyMainCat() -> CategoryModelClass? {
    let ids = Int.random(in: 0..<2)
    if ids == 0 {
        return CategoryModelClass.init(id: ids, catName: "Order")
    }
    else {
        return CategoryModelClass.init(id: ids, catName: "Meal")
    }
}

func DummySUbCat() -> CategoryModelClass? {
    let ids = Int.random(in: 1..<7)
    var title: String = ""
    switch ids {
    case 1:
        title = "Eggs"
        break
    case 2:
        title = "SandWich"
        break
    case 3:
        title = "South"
        break
    case 4:
        title = "Breakfast"
        break
    case 5:
        title = "Brinner"
        break
    case 6:
        title = "Lunch"
        break
    default:
        title = "Eggs"
        break
    }
    return CategoryModelClass.init(id: ids, catName: title)
}

func DummyFoodListing2() -> [FoodModels]? {
    let json = """
    {
      "status": true,
      "code": 200,
      "message": "Get Food listing",
      "data": {
        "currenct_page": 1,
        "last_page": 5,
        "orders": [
          {
            "id": 1001001,
            "title": "BBQ-Chicken 'n' Cheese Sandwich",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Shredded chicken, seasoned with sauces, seasonings and cheese, between toasted, chipotle mayo spread brown bread slices is all that you would need for a scrumptious anytime-meal. Trust us, you'll love it.",
            "longdesc": "INGREDIENTS Chicken, BBQ Sauce, Brown Bread, Seasonings, Worcestershire Sauce, Dijon Mustard, Cheese, Parsley, Chipotle Mayo, Tomato Ketchup, Herbs Thyme",
            "price": 25.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10010,
              "cat_name": "Sandwich"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          },
          {
            "id": 1001002,
            "title": "Spinach Corn Sandwich",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "This sandwich has fresh spinach and sweet corn which are cooked in a cheesy sauce, stuffed between toasted brown bread with cheese slices giving you the best snack option anytime of the day!",
            "longdesc": "Brown Bread, Cheddar, Spinach, Golden Corn, Béchamel",
            "price": 23.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10010,
              "cat_name": "Sandwich"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": true,
            "isPackage": false
          },
          {
            "id": 1001003,
            "title": "Chicken Tikka Sandwich",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Enjoy the best of fusion flavours in this flavoursome sandwich. Chicken pieces are flavoured with a in-house tikka masala and layered in a toasted brown bread with chipotle-mayo, purple cabbage, green peppers and carrot.",
            "longdesc": "Brown Bread, Chicken Leg Boneless, Green Chilli, Purple Cabbage, Green Bell Pepper, Carrot, Mayonnaise, Chipotle Seasoning, Indian Spices,, Fresh Cream",
            "price": 28.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10010,
              "cat_name": "Sandwich"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          },
          {
            "id": 1001004,
            "title": "Mediterranean Falafel Sandwich",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Come experience the magic of true Mediterranean flavours with this loaded 6-inch sandwich. Falafels are drizzled with aioli sauce, layered in a freshly prepared homemade Focaccia bread, alongwith coleslaw, lettuce and topped with grated cheese.",
            "longdesc": "Focaccia Bread, Chickpeas, Onion, Parsley, Mayonnaise, Carrot, Cabbage, Green Capsicum, Cheese, Lettuce, Garlic",
            "price": 30.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10010,
              "cat_name": "Sandwich"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": true,
            "isPackage": false
          },
          {
            "id": 1002001,
            "title": "Lebanese Falafel Rice Bowl",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "A bowl full of greens, veggies, olives, falafel, tomato salsa and salads. Rice is sauteed with onions, garlic, carrot, olives, parsley and seasonings. Served with Tzatziki, tomato pineapple salsa, Israeli salad and warm falafels. It's a must-have bowl. All our meals are prepared fresh on order.",
            "longdesc": "Chickpeas, Onion, Rice, Green Chilli, Carrot, Seasoning, Tomato Salsa, Red Cabbage, English Cucumber, Tzatziki, Jalapeno, Black Olives,, Hung Curd,Pineapple",
            "price": 25.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10020,
              "cat_name": "Continental"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": true,
            "isPackage": false
          },
          {
            "id": 1002002,
            "title": "Fusilli Arrabbiata",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Fusilli tossed in a tomato-basil arrabiatta sauce along with bell peppers, onion, carrots, zucchini and broccoli,",
            "longdesc": "Fusilli, Tomato, Zucchini, Red Chilli Flakes, Bell Pepper, Broccoli, Carrot, Basil, Oregano, White Wine Vinegar, Olive Oil",
            "price": 30.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10020,
              "cat_name": "Continental"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": true,
            "isPackage": false
          },
          {
            "id": 1002003,
            "title": "Meatballs with Creamy Tomato Spaghetti",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "An Italian household staple has become a food fave for the rest of the world. All the flavours of the classic dish are captured in this nostalgic indulgence. Tender mince chicken meatballs, baked and cooked in a savoury tomato sauce, along with veggies and served with silky strands of spaghetti. You will cherish every bite!",
            "longdesc": "Spaghetti, Chicken Mince, Onion, Celery, Carrot, Thyme, Parsley, Eggs, Zucchini, Tri Bell Peppers, Mierpoix, Tomato Sauce, White Sauce, Cream, Basil, Parmesan Cheese, Olives",
            "price": 35.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10020,
              "cat_name": "Continental"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          },
          {
            "id": 1002004,
            "title": "Mexican-Burrito Bowl",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Here is our all time favourite signature burrito bowl. Paneer steaks, infused with hot and tangy habanero-jalapeno duo, is grilled, sliced and served with an exciting satiating combo of tomato-paprika rice, spicy refried beans, crunchy roasted-corn salsa, tomato salsa and sour cream. All our meals are prepared fresh on order.",
            "longdesc": "Rice, Paneer, Red Kidney-Bean, Tomato, Paprika, Jalapeño, Oregano, Broccoli, Habanero Spice-Mix, Golden Corn",
            "price": 30.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10020,
              "cat_name": "Continental"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": true,
            "isPackage": false
          },
          {
            "id": 1002005,
            "title": "Fish 'n' Chips",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "An appetizer we bring to you which nobody can resist the delectable combination of moist, white fish batter-fried to a crisp served on a portion of warm potato wedges. All our meals are prepared fresh on order.",
            "longdesc": "Basa, Potato, Panko Crumbs, Tartar Sauce",
            "price": 25.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10020,
              "cat_name": "Continental"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          },
          {
            "id": 1002006,
            "title": "Honey Mustard Chicken Bowl",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "A delicious combination of wild honey & French mustard marinated chicken oven roasted and served along with herb rice topped with mexican tomato pineapple salsa. A perfect balance between zesty mustard and the Honey!",
            "longdesc": "Basmati Rice, Chicken Breast Boneless, Honey, Dijon Mustard, Tri Bell Peppers, Cream, Onion, Carrot, Cheese, Seasonings, Parsley, Rosemary, Tomato, Thyme Herbs, Pineapple",
            "price": 30.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10020,
              "cat_name": "Continental"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          },
          {
            "id": 1003001,
            "title": "Teriyaki-Chicken-Quinoa-Superbowl",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "This Teriyaki Chicken Quinoa Bowl is a perfect healthy meal option for lunch or dinner. Featuring a juicy chicken leg, diced and marinated in Teriyaki sauce. Served with a delicious bell pepper quinoa brown rice. It's high in protein, fiber, healthy and delicious!",
            "longdesc": "Chicken Leg Boneless, Quinoa Brown Rice,Light Soy , Chilli Paste , Garlic , Sesame Seeds., Egg, Bell Peppers, Onion, Leeks.",
            "price": 30.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10030,
              "cat_name": "Healthy"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          },
          {
            "id": 1003002,
            "title": "Stir-Fried-Chilli-Paneer Superbowl",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "This peppery, spicy, and tangy chilli-infused dish is popular on our list of starters and appetizers. When served with a quinoa brown fried rice, this Indo-Chinese combo packs a mean, healthy punch.",
            "longdesc": "Paneer, Brown Rice, Quinoa, Bell Pepper, Green Bean, Bok Choy, Broccoli, Red Chilli, Light Soy Sauce, Dark Soy Sauce, Vinegar",
            "price": 30.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10030,
              "cat_name": "Healthy"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": true,
            "isPackage": false
          },
          {
            "id": 1003003,
            "title": "Keto Club Chicken Salad",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Looking for a protein-packed and delicious on-the-go meal? Marinated chicken is seared and grilled to perfection. Veggies like cucumber, cabbage, tomato, mixed fresh lettuce is topped with boiled egg and seared-diced chicken. Deliciously dressed with a white cheese dressing.",
            "longdesc": "Chicken Breast Boneless, Cabbage, Lettuce, Tomato, Chicken, Dijon Mustard, Mayonnaise, Fresh Cream, Herbs, Cucumber, Egg",
            "price": 30.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10030,
              "cat_name": "Healthy"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          },
          {
            "id": 1003004,
            "title": "Chicken Caesar Salad",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Grilled chicken, generous amount of crunchy lettuce, cherry tomatoes and croutons, seasoned and tossed with olive oil and parmesan. Served with a creamy Caesar dressing.",
            "longdesc": "Parmesan, Olive Oil, Dijon Mustard, Thyme, Parsley, Cherry Tomato, Lettuce, Mayonnaise, Yogurt, Chicken",
            "price": 30.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10030,
              "cat_name": "Healthy"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          },
          {
            "id": 1003005,
            "title": "Keto Peri Peri Grilled Chicken Steak",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Our chicken-steak bowl isn’t just delicious but a KETO meal too! Slices of peri-peri spiced, grilled chicken breast is served with peppered, assorted veggies and a basil-flavoured cheese jus!",
            "longdesc": "Chicken, Eri Peri Spice Mix, Mushroom, Cauliflower, Broccoli, Cheese Sauce, Basil, Pepper",
            "price": 35.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10030,
              "cat_name": "Healthy"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          },
          {
            "id": 1004001,
            "title": "Guacamole Falafel Burger",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Chickpea falafel on a bed of home made guacamole with tomatoes and gherkins - served with french fries",
            "longdesc": "",
            "price": 30.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10040,
              "cat_name": "Burgers"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": true,
            "isPackage": false
          },
          {
            "id": 1004002,
            "title": "Crunchy Paneer Burger",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Crunchy paneer patty with gherkins, tomato slices and lettuce flavored with homemade thahini - served with french fries",
            "longdesc": "",
            "price": 30.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10040,
              "cat_name": "Burgers"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": true,
            "isPackage": false
          },
          {
            "id": 1004003,
            "title": "Double Shot Boss Burger",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Home made baked egg and chicken patty with gherkins tomato slices and lettuce flavored with home made tahini sauce - served with french fries.",
            "longdesc": "",
            "price": 40.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10040,
              "cat_name": "Burgers"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          },
          {
            "id": 1005001,
            "title": "Poha",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "An all-day favourite - a sumptuous portion of delicious home-made kandhe poha cooked with veggies & peanuts",
            "longdesc": "",
            "price": 25.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10050,
              "cat_name": "Indian"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": true,
            "isPackage": false
          },
          {
            "id": 1005002,
            "title": "Tossed Idlis With Chutney",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Idli chunks tossed with in house masalas and spices. Served with chutney.",
            "longdesc": "",
            "price": 20.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10050,
              "cat_name": "Indian"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": true,
            "isPackage": false
          },
          {
            "id": 1005003,
            "title": "Onion Paratha",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Onion mixed into a fresh and flavorful paratha combined with homemade spices and glazed with desi ghee. A perfect dish served with pickle and brekkie special greek yogurt.",
            "longdesc": "",
            "price": 25.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10050,
              "cat_name": "Indian"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": true,
            "isPackage": false
          },
          {
            "id": 1002007,
            "title": "Spinach And Cheese Omelet",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Loaded with protein irons and vitamins - makes for an amazing breakfast - served with our in house garlic bread.",
            "longdesc": "",
            "price": 25.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10020,
              "cat_name": "Continental"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          },
          {
            "id": 1002008,
            "title": "Mushroom Cheese Omlette",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "2 egg cheese and mushroom omelette served with garlic bread.",
            "longdesc": "",
            "price": 28.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10020,
              "cat_name": "Continental"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          },
          {
            "id": 1002009,
            "title": "Caramel And Banana Pan Cakes",
            "itemimage": "https://source.unsplash.com/random/200x200",
            "gallery": [
              "https://source.unsplash.com/random/200x200"
            ],
            "shortdesc": "Whole wheat pancakes served with caramelized banana and our in house caramel sauce.",
            "longdesc": "",
            "price": 30.0,
            "qty": 1,
            "cattegory": {
              "id": 100,
              "cat_name": "order"
            },
            "sub_cattegory": {
              "id": 10020,
              "cat_name": "Continental"
            },
            "nutri_info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "info": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "works": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            "isveg": false,
            "isPackage": false
          }
        ],
        "meal": [
          
        ]
      }
    }
    """.data(using: .utf8)!

    let jsonObject = JSON(json)
    let foodroot = FoodRootClass.init(fromJson: jsonObject)
    return foodroot.data.orders
}

func Dummysearchlisting() -> GlobalSearchModelData? {
    let data: GlobalSearchModelData! = GlobalSearchModelData.init(currenctPage: "2", lastPage: "5", meals: dummyMealListing(), food: DummyFoodListing())
    return data
}

func DummyFoodListing() -> [FoodModelClass]? {
    var food: [FoodModelClass]! = []
    
    for _ in 0...4 {
        food.append(FoodModelClass.init(id: randomID(digits: 2), title: randomString(length: 5), foodimage: dummyIMG(), gallery: dummygallery(), foodShortdesc: randomString(length: 20), foodLongdesc: randomString(length: 80), price: DummyPrice(), cattegory: DummyMainCat(), subCattegory: DummySUbCat(), nutriInfo: randomString(length: 80), info: randomString(length: 80), isveg: DummyVeg_non()))
    }
    return food
}

func dummyMealListing() -> [MealModelClass]? {
    var meal: [MealModelClass] = []
    
    for _ in 0...5 {
        meal.append(MealModelClass.init(id: randomID(digits: 2), title: randomString(length: 5), mealimage: dummyIMG(), gallery: dummygallery(), mealShortdesc: randomString(length: 20), mealLongdesc: randomString(length: 50), price: DummyPrice(), cattegory: DummyMainCat(), subCattegory: DummySUbCat(), nutriInfo: randomString(length: 80), terms: randomString(length: 80), works: randomString(length: 80), isveg: DummyVeg_non(), items: DummyFoodListing()))
    }
    return meal
}

func dummyNotification() -> [NotificationModelClass] {
    var notification: [NotificationModelClass] = []
    
    for _ in 0...5 {
        notification.append(NotificationModelClass.init(id: randomID(digits: 2), title: randomString(length: 5), shortdesc: randomString(length: 50), longdesc: randomString(length: 500), gallery: dummygallery(), terms: randomString(length: 50), notificationType: randomString(length: 5), date: randomString(length: 5)))
    }
    return notification
}

func DummCartdata() -> CartListModelClass? {
    let cart = CartListModelClass.init(id: randomID(digits: 2), title: randomString(length: 5), foodimage: randomString(length: 5), gallery: dummygallery(), foodShortdesc: randomString(length: 5), foodLongdesc: randomString(length: 5), price: DummyPrice(), cattegory: CategoryModelClass.init(id: randomID(digits: 2), catName: randomString(length: 5)), subCattegory: CategoryModelClass.init(id: randomID(digits: 2), catName: randomString(length: 5)), nutriInfo: randomString(length: 5), info: randomString(length: 5), isveg: true, mealimage: randomString(length: 5), mealShortdesc: randomString(length: 5), mealLongdesc: randomString(length: 5), terms: randomString(length: 5), works: randomString(length: 5), fooditems: [FoodModelClass.init(id: randomID(digits: 2), title: randomString(length: 5), foodimage: dummyIMG(), gallery: dummygallery(), foodShortdesc: randomString(length: 20), foodLongdesc: randomString(length: 80), price: DummyPrice(), cattegory: DummyMainCat(), subCattegory: DummySUbCat(), nutriInfo: randomString(length: 80), info: randomString(length: 80), isveg: DummyVeg_non())], mealitems: [MealModelClass.init(id: randomID(digits: 2), title: randomString(length: 5), mealimage: dummyIMG(), gallery: dummygallery(), mealShortdesc: randomString(length: 20), mealLongdesc: randomString(length: 50), price: DummyPrice(), cattegory: DummyMainCat(), subCattegory: DummySUbCat(), nutriInfo: randomString(length: 80), terms: randomString(length: 80), works: randomString(length: 80), isveg: DummyVeg_non(), items: DummyFoodListing())])
    return cart
}

func DummyOrderHistory() -> [OrderHistoryModelData]? {
    let hostory = OrderHistoryModelData.init(id: randomID(digits: 2), title: randomString(length: 5), foodimage: randomString(length: 5), gallery: dummygallery(), foodShortdesc: randomString(length: 50), foodLongdesc: randomString(length: 150), price: DummyPrice(), cattegory: DummyMainCat(), subCattegory: DummySUbCat(), nutriInfo: randomString(length: 50), info: randomString(length: 50), isveg: true, datetime: randomString(length: 50), orderstatus: randomString(length: 50), paymentmode: randomString(length: 50), paybleamount: DummyPrice(), paymentStatus: randomString(length: 50), recipes: randomString(length: 50), deliveryaddress: randomString(length: 50), community: DummyCommunitydata()?.first, mealimage: randomString(length: 50), mealShortdesc: randomString(length: 50), mealLongdesc: randomString(length: 50), terms: randomString(length: 50), works: randomString(length: 50), items: DummyFoodListing())
    return [hostory]
}

func DummyCommunitydata() -> [CommunityModelClass]? {
    var community: [CommunityModelClass] = []
    
    for _ in 0...5 {
        community.append(CommunityModelClass.init(id: randomID(digits: 2), title: randomString(length: 5), address: randomString(length: 5), shortdesc: randomString(length: 5), lat: 12345.09, long: 42134.09))
    }
    return community
}
