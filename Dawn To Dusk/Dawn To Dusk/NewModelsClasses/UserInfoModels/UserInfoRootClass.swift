//
//	UserInfoRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class UserInfoRootClass : NSObject, NSCoding{
    
    var code : Int!
    var data : UserInfoData!
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
            data = UserInfoData(fromJson: dataJson)
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
        data = aDecoder.decodeObject(forKey: "data") as? UserInfoData
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
