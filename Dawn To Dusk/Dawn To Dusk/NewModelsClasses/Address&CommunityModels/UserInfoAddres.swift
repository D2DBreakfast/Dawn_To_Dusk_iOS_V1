//
//	UserInfoAddres.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class UserInfoAddresRootClass : NSObject, NSCoding{
    
    var code : Int!
    var data : UserInfoAddres!
    var status : Bool!
    var message : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        code = json["code"].intValue
        let dataJson = json["data"]
        if !dataJson.isEmpty{
            data = UserInfoAddres(fromJson: dataJson)
        }
        status = json["status"].boolValue
        message = json["message"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if code != nil{
            dictionary["code"] = code
        }
        if data != nil{
            dictionary["data"] = data.toDictionary()
        }
        if status != nil{
            dictionary["status"] = status
        }
        if message != nil{
            dictionary["message"] = message
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        code = aDecoder.decodeObject(forKey: "code") as? Int
        data = aDecoder.decodeObject(forKey: "data") as? UserInfoAddres
        status = aDecoder.decodeObject(forKey: "status") as? Bool
        message = aDecoder.decodeObject(forKey: "message") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        
    }
    
}

class UserInfoAddres : NSObject, NSCoding{
    
    var address : String!
    var id : Int!
    var isDefault : Bool!
    var lat : Float!
    var location : String!
    var longField : Float!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        address = json["address"].stringValue
        id = json["id"].intValue
        isDefault = json["isDefault"].boolValue
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
        if id != nil{
            dictionary["id"] = id
        }
        if isDefault != nil{
            dictionary["isDefault"] = isDefault
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
        id = aDecoder.decodeObject(forKey: "id") as? Int
        isDefault = aDecoder.decodeObject(forKey: "isDefault") as? Bool
        lat = aDecoder.decodeObject(forKey: "lat") as? Float
        location = aDecoder.decodeObject(forKey: "location") as? String
        longField = aDecoder.decodeObject(forKey: "long") as? Float
        
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
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isDefault != nil{
            aCoder.encode(isDefault, forKey: "isDefault")
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
        
    }
    
}
