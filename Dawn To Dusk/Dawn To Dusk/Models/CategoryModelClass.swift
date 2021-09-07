//
//  CategoryModel.swift
//  Dawn To Dusk
//
//  Created by Hiren on 29/07/21.
//

import Foundation

// MARK: - CategoryModelRootClass
class CategoryModelRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: CategoryModelData?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: CategoryModelData?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - CategoryModelData
class CategoryModelData: Codable {
    var category: [CategoryModelClass]?

    enum CodingKeys: String, CodingKey {
        case category = "category"
    }

    init(category: [CategoryModelClass]?) {
        self.category = category
    }
}

// MARK: - CategoryModelCategory
class CategoryModelClass: Codable {
    var id: Int?
    var catName: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case catName = "cat_name"
    }

    init(id: Int?, catName: String?) {
        self.id = id
        self.catName = catName
    }
}
