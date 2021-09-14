//
//	UserInfoCommunity.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class UserInfoCommunity : NSObject, NSCoding{
    
    var address : String!
    var title : String!
    var id : Int!
    var lat : Float!
    var location : String!
    var line1 : String!
    var line2 : String!
    var longField : Float!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        address = json["address"].stringValue
        title = json["title"].stringValue
        line1 = json["line1"].stringValue
        line2 = json["line2"].stringValue
        id = json["id"].intValue
        lat = json["lat"].floatValue
        location = json["location"].stringValue
        longField = json["long"].floatValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if address != nil{
            dictionary["address"] = address
        }
        if title != nil{
            dictionary["title"] = title
        }
        if line1 != nil{
            dictionary["line1"] = line1
        }
        if line2 != nil{
            dictionary["line2"] = line2
        }
        if id != nil{
            dictionary["id"] = id
        }
        if lat != nil{
            dictionary["lat"] = lat
        }
        if location != nil{
            dictionary["location"] = location
        }
        if longField != nil{
            dictionary["long"] = longField
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        address = aDecoder.decodeObject(forKey: "address") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        lat = aDecoder.decodeObject(forKey: "lat") as? Float
        location = aDecoder.decodeObject(forKey: "location") as? String
        longField = aDecoder.decodeObject(forKey: "long") as? Float
        line1 = aDecoder.decodeObject(forKey: "line1") as? String
        line2 = aDecoder.decodeObject(forKey: "line2") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if lat != nil{
            aCoder.encode(lat, forKey: "lat")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }
        if longField != nil{
            aCoder.encode(longField, forKey: "long")
        }
        if line1 != nil{
            aCoder.encode(line1, forKey: "line1")
        }
        if line2 != nil{
            aCoder.encode(line2, forKey: "line2")
        }
    }
    
}
