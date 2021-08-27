//
//  MealModel.swift
//  Dawn To Dusk
//
//  Created by Hiren on 29/07/21.
//

import Foundation

// MARK: - MealModelRootClass
class MealModelRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: MealModelData?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: MealModelData?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - MealModelData
class MealModelData: Codable {
    var currenctPage: Int?
    var lastPage: Int?
    var meals: [MealModelClass]?

    enum CodingKeys: String, CodingKey {
        case currenctPage = "currenct_page"
        case lastPage = "last_page"
        case meals = "meals"
    }

    init(currenctPage: Int?, lastPage: Int?, meals: [MealModelClass]?) {
        self.currenctPage = currenctPage
        self.lastPage = lastPage
        self.meals = meals
    }
}

// MARK: - MealModelClass
class MealModelClass: Codable {
    var id: Int?
    var title: String?
    var mealimage: String?
    var gallery: [String]?
    var mealShortdesc: String?
    var mealLongdesc: String?
    var price: Double?
    var cattegory: CategoryModelClass?
    var subCattegory: CategoryModelClass?
    var nutriInfo: String?
    var terms: String?
    var works: String?
    var isveg: Bool?
    var items: [FoodModelClass]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case mealimage = "mealimage"
        case gallery = "gallery"
        case mealShortdesc = "meal_shortdesc"
        case mealLongdesc = "meal_longdesc"
        case price = "price"
        case cattegory = "cattegory"
        case subCattegory = "sub_cattegory"
        case nutriInfo = "nutri_info"
        case terms = "terms"
        case works = "works"
        case isveg = "isveg"
        case items = "items"
    }

    init(id: Int?, title: String?, mealimage: String?, gallery: [String]?, mealShortdesc: String?, mealLongdesc: String?, price: Double?, cattegory: CategoryModelClass?, subCattegory: CategoryModelClass?, nutriInfo: String?, terms: String?, works: String?, isveg: Bool?, items: [FoodModelClass]?) {
        self.id = id
        self.title = title
        self.mealimage = mealimage
        self.gallery = gallery
        self.mealShortdesc = mealShortdesc
        self.mealLongdesc = mealLongdesc
        self.price = price
        self.cattegory = cattegory
        self.subCattegory = subCattegory
        self.nutriInfo = nutriInfo
        self.terms = terms
        self.works = works
        self.isveg = isveg
        self.items = items
    }
}
