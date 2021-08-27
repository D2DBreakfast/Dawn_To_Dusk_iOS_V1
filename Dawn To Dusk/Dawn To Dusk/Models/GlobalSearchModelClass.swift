//
//  GlobalSearchModelClass.swift
//  Dawn To Dusk
//
//  Created by Hiren on 04/08/21.
//

import Foundation

// MARK: - GlobalSearchModelRootClass
class GlobalSearchModelRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: GlobalSearchModelData?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: GlobalSearchModelData?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - GlobalSearchModelData
class GlobalSearchModelData: Codable {
    var currenctPage: String?
    var lastPage: String?
    var meals: [MealModelClass]?
    var food: [FoodModelClass]?

    enum CodingKeys: String, CodingKey {
        case currenctPage = "currenct_page"
        case lastPage = "last_page"
        case meals = "meals"
        case food = "food"
    }

    init(currenctPage: String?, lastPage: String?, meals: [MealModelClass]?, food: [FoodModelClass]?) {
        self.currenctPage = currenctPage
        self.lastPage = lastPage
        self.meals = meals
        self.food = food
    }
}
