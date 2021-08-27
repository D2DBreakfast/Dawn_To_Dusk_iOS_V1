//
//  CategoryData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

struct CategoryData {

    let category: [CategoryModels]?

    init(_ json: JSON) {
        category = json["category"].arrayValue.map { CategoryModels($0) }
    }

}
