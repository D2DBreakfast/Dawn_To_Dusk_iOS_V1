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
