//
//  OrderHistoryModelClass.swift
//  Dawn To Dusk
//
//  Created by Hiren on 04/08/21.
//

import Foundation

// MARK: - OrderHistoryModelRootClass
class OrderHistoryModelRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: [OrderHistoryModelData]?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: [OrderHistoryModelData]?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - OrderHistoryModelData
class OrderHistoryModelData: Codable {
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
    var datetime: String?
    var orderstatus: String?
    var paymentmode: String?
    var paybleamount: Double?
    var paymentStatus: String?
    var recipes: String?
    var deliveryaddress: String?
    var community: CommunityModelClass?
    var mealimage: String?
    var mealShortdesc: String?
    var mealLongdesc: String?
    var terms: String?
    var works: String?
    var items: [FoodModelClass]?

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
        case datetime = "datetime"
        case orderstatus = "orderstatus"
        case paymentmode = "paymentmode"
        case paybleamount = "paybleamount"
        case paymentStatus = "payment_status"
        case recipes = "Recipes "
        case deliveryaddress = "deliveryaddress"
        case community = "Community"
        case mealimage = "mealimage"
        case mealShortdesc = "meal_shortdesc"
        case mealLongdesc = "meal_longdesc"
        case terms = "terms"
        case works = "works"
        case items = "items"
    }

    init(id: Int?, title: String?, foodimage: String?, gallery: [String]?, foodShortdesc: String?, foodLongdesc: String?, price: Double?, cattegory: CategoryModelClass?, subCattegory: CategoryModelClass?, nutriInfo: String?, info: String?, isveg: Bool?, datetime: String?, orderstatus: String?, paymentmode: String?, paybleamount: Double?, paymentStatus: String?, recipes: String?, deliveryaddress: String?, community: CommunityModelClass?, mealimage: String?, mealShortdesc: String?, mealLongdesc: String?, terms: String?, works: String?, items: [FoodModelClass]?) {
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
        self.datetime = datetime
        self.orderstatus = orderstatus
        self.paymentmode = paymentmode
        self.paybleamount = paybleamount
        self.paymentStatus = paymentStatus
        self.recipes = recipes
        self.deliveryaddress = deliveryaddress
        self.community = community
        self.mealimage = mealimage
        self.mealShortdesc = mealShortdesc
        self.mealLongdesc = mealLongdesc
        self.terms = terms
        self.works = works
        self.items = items
    }
}
