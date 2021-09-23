//
//    NotificationData.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class NotificationData : NSObject, NSCoding{

    var notification : [NotificationModels]!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        notification = [NotificationModels]()
        let notificationArray = json["notification"].arrayValue
        for notificationJson in notificationArray{
            let value = NotificationModels(fromJson: notificationJson)
            notification.append(value)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if notification != nil{
            var dictionaryElements = [[String:Any]]()
            for notificationElement in notification {
                dictionaryElements.append(notificationElement.toDictionary())
            }
            dictionary["notification"] = dictionaryElements
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         notification = aDecoder.decodeObject(forKey: "notification") as? [NotificationModels]

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if notification != nil{
            aCoder.encode(notification, forKey: "notification")
        }

    }

}
