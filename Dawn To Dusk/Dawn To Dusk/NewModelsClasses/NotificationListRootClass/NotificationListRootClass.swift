//
//  NotificationListRootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class NotificationListRootClass {
    
    let Status: Bool?
    let Code: Int?
    let message: String?
    let Data: NotificationData2?
    
    init(_ json: JSON) {
        Status = json["status"].boolValue
        Code = json["code"].intValue
        message = json["message"].stringValue
        Data = NotificationData2(json["data"])
    }
    
}


/*
 let json = """
 {
 "Status": true,
 "Code": 200,
 "message": "Get category or sub category listing",
 "Data": {
 "category": [
 {
 "id": 123,
 "cat_name": "",
 "cat_image": "",
 "isveg": false
 },
 {
 "id": 123,
 "cat_name": "",
 "cat_image": "",
 "isveg": true
 }
 ]
 }
 }
 """.data(using: .utf8)!
 
 let jsonObject = JSON(json)
 let model = NotificationListRootClass(jsonObject)
 */
