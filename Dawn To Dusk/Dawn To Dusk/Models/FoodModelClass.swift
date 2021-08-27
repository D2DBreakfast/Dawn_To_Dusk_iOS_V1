//
//  FoodModel.swift
//  Dawn To Dusk
//
//  Created by Hiren on 29/07/21.
//

import Foundation

// MARK: - FoodModelRootClass
class FoodModelRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: FoodModelData?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: FoodModelData?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - FoodModelData
class FoodModelData: Codable {
    var currenctPage: Int?
    var lastPage: Int?
    var food: [FoodModelClass]?

    enum CodingKeys: String, CodingKey {
        case currenctPage = "currenct_page"
        case lastPage = "last_page"
        case food = "food"
    }

    init(currenctPage: Int?, lastPage: Int?, food: [FoodModelClass]?) {
        self.currenctPage = currenctPage
        self.lastPage = lastPage
        self.food = food
    }
}

// MARK: - FoodModelFood
class FoodModelClass: Codable {
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
    }

    init(id: Int?, title: String?, foodimage: String?, gallery: [String]?, foodShortdesc: String?, foodLongdesc: String?, price: Double?, cattegory: CategoryModelClass?, subCattegory: CategoryModelClass?, nutriInfo: String?, info: String?, isveg: Bool?) {
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
    }
}

