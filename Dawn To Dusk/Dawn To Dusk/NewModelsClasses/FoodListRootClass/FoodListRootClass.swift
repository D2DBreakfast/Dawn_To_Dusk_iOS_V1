//
//  FoodListRootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class FoodListRootClass {
    
    let Status: Bool?
    let Code: Int?
    let message: String?
    let Data: FoodData?
    
    init(_ json: JSON) {
        Status = json["status"].boolValue
        Code = json["code"].intValue
        message = json["message"].stringValue
        Data = FoodData(json["data"])
    }
    
}
