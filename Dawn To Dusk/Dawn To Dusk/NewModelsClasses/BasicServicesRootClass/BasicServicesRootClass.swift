//
//  BasicServicesRootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class BasicServicesRootClass {
    
    let Status: Bool?
    let Code: Int?
    let message: String?
    let Data: BasicServicesData?
    
    init(_ json: JSON) {
        Status = json["status"].boolValue
        Code = json["code"].intValue
        message = json["message"].stringValue
        Data = BasicServicesData(json["data"])
    }
    
}
