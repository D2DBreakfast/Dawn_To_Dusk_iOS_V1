//
//  FoodModels.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class FoodModels {
    
    let id: Int?
    let title: String?
    let itemimage: String?
    let gallery: [String]?
    let shortdesc: String?
    let longdesc: String?
    let price: Double?
    let qty: Int?
    let cattegory: CategoryModels?
    let subCattegory: CategoryModels?
    let nutriInfo: String?
    let terms: String?
    let info: String?
    let works: String?
    let isveg: Bool?
    let isPackage: Bool?
    let items: [FoodModels]?
    
    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        itemimage = json["itemimage"].stringValue
        gallery = json["gallery"].arrayValue.map { $0.stringValue }
        shortdesc = json["shortdesc"].stringValue
        longdesc = json["longdesc"].stringValue
        price = json["price"].doubleValue
        qty = json["qty"].intValue
        cattegory = CategoryModels(json["cattegory"])
        subCattegory = CategoryModels(json["sub_cattegory"])
        nutriInfo = json["nutri_info"].stringValue
        terms = json["terms"].stringValue
        info = json["info"].stringValue
        works = json["works"].stringValue
        isveg = json["isveg"].boolValue
        isPackage = json["isPackage"].boolValue
        items = json["items"].arrayValue.map { FoodModels($0) }
    }
    
}
