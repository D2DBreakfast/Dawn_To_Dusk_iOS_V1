//
//  NotificationData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class NotificationData2 {
    
    let notification: [NotificationModels]?
    
    init(_ json: JSON) {
        notification = json["notification"].arrayValue.map { NotificationModels($0) }
    }
    
}
