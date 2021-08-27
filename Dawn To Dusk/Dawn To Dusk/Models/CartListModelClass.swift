//
//  CartListModelClass.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 03/08/21.
//

import Foundation

// MARK: - CartListModelRootClass
class CartListModelRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: [CartListModelClass]?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: [CartListModelClass]?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - CartListModelClass
class CartListModelClass: Codable {
    var id: Int?
    var title: String?
    var foodimage: String?
    var gallery: [String]?
    var foodShortdesc: String?
    var foodLongdesc: String?
    var price: Double?
    var cattegory: CategoryModelClass?
    var subCattegory: CategoryModelClass?
    var nutriInfo: String?
    var info: String?
    var isveg: Bool?
    var mealimage: String?
    var mealShortdesc: String?
    var mealLongdesc: String?
    var terms: String?
    var works: String?
    var fooditems: [FoodModelClass]?
    var mealitems: [MealModelClass]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case foodimage = "foodimage"
        case gallery = "gallery"
        case foodShortdesc = "food_shortdesc"
        case foodLongdesc = "food_longdesc"
        case price = "price"
        case cattegory = "cattegory"
        case subCattegory = "sub_cattegory"
        case nutriInfo = "nutri_info"
        case info = "info"
        case isveg = "isveg"
        case mealimage = "mealimage"
        case mealShortdesc = "meal_shortdesc"
        case mealLongdesc = "meal_longdesc"
        case terms = "terms"
        case works = "works"
        case fooditems = "fooditems"
        case mealitems = "mealitems"
    }

    init(id: Int?, title: String?, foodimage: String?, gallery: [String]?, foodShortdesc: String?, foodLongdesc: String?, price: Double?, cattegory: CategoryModelClass?, subCattegory: CategoryModelClass?, nutriInfo: String?, info: String?, isveg: Bool?, mealimage: String?, mealShortdesc: String?, mealLongdesc: String?, terms: String?, works: String?, fooditems: [FoodModelClass]?, mealitems: [MealModelClass]?) {
        self.id = id
        self.title = title
        self.foodimage = foodimage
        self.gallery = gallery
        self.foodShortdesc = foodShortdesc
        self.foodLongdesc = foodLongdesc
        self.price = price
        self.cattegory = cattegory
        self.subCattegory = subCattegory
        self.nutriInfo = nutriInfo
        self.info = info
        self.isveg = isveg
        self.mealimage = mealimage
        self.mealShortdesc = mealShortdesc
        self.mealLongdesc = mealLongdesc
        self.terms = terms
        self.works = works
        self.fooditems = fooditems
        self.mealitems = mealitems
    }
}
