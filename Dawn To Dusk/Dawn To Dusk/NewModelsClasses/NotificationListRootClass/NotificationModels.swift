//
//  NotificationModels.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class NotificationModels {
    
    let id: Int?
    let title: String?
    let shortdesc: String?
    let longdesc: String?
    let gallery: [String]?
    let terms: String?
    let notificationType: String?
    let date: String?
    
    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        shortdesc = json["shortdesc"].stringValue
        longdesc = json["longdesc"].stringValue
        gallery = json["gallery"].arrayValue.map { $0.stringValue }
        terms = json["terms"].stringValue
        notificationType = json["notification_type"].stringValue
        date = json["date"].stringValue
    }
    
}
