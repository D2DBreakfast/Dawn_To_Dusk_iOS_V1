//
//  CategoryModels.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

struct CategoryModels {

    let id: Int?
    let catName: String?
    let catImage: String?
    let isveg: Bool?

    init(_ json: JSON) {
        id = json["id"].intValue
        catName = json["cat_name"].stringValue
        catImage = json["cat_image"].stringValue
        isveg = json["isveg"].boolValue
    }

}
