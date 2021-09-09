//
//    NotificationModels.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class NotificationModels : NSObject, NSCoding{
    
    var date : String!
    var id : Int!
    var longdesc : String!
    var notificationType : String!
    var shortdesc : String!
    var terms : String!
    var title : String!
    var gallery : [String]!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        date = json["date"].stringValue
        id = json["id"].intValue
        longdesc = json["longdesc"].stringValue
        notificationType = json["notification_type"].stringValue
        shortdesc = json["shortdesc"].stringValue
        terms = json["terms"].stringValue
        title = json["title"].stringValue
        gallery = json["gallery"].arrayValue.map { $0.stringValue }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if date != nil{
            dictionary["date"] = date
        }
        if id != nil{
            dictionary["id"] = id
        }
        if longdesc != nil{
            dictionary["longdesc"] = longdesc
        }
        if notificationType != nil{
            dictionary["notification_type"] = notificationType
        }
        if shortdesc != nil{
            dictionary["shortdesc"] = shortdesc
        }
        if terms != nil{
            dictionary["terms"] = terms
        }
        if title != nil{
            dictionary["title"] = title
        }
        if gallery != nil {
            dictionary["gallery"] = gallery.map { $0 }
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        date = aDecoder.decodeObject(forKey: "date") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        longdesc = aDecoder.decodeObject(forKey: "longdesc") as? String
        notificationType = aDecoder.decodeObject(forKey: "notification_type") as? String
        shortdesc = aDecoder.decodeObject(forKey: "shortdesc") as? String
        terms = aDecoder.decodeObject(forKey: "terms") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        gallery = aDecoder.decodeObject(forKey: "gallery") as? [String]
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if date != nil{
            aCoder.encode(date, forKey: "date")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if longdesc != nil{
            aCoder.encode(longdesc, forKey: "longdesc")
        }
        if notificationType != nil{
            aCoder.encode(notificationType, forKey: "notification_type")
        }
        if shortdesc != nil{
            aCoder.encode(shortdesc, forKey: "shortdesc")
        }
        if terms != nil{
            aCoder.encode(terms, forKey: "terms")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if gallery != nil{
            aCoder.encode(gallery, forKey: "gallery")
        }
        
    }
    
}
