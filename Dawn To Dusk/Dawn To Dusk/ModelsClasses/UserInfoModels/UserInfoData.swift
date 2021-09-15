//
//	UserInfoData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class UserInfoData : NSObject, NSCoding{
    
    var accessToken : String!
    var idToken : String!
    var refreshToken : String!
    var user : UserInfoUser!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        accessToken = json["accessToken"].stringValue
        idToken = json["idToken"].stringValue
        refreshToken = json["refreshToken"].stringValue
        let userJson = json["user"]
        if !userJson.isEmpty{
            user = UserInfoUser(fromJson: userJson)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accessToken != nil{
            dictionary["accessToken"] = accessToken
        }
        if idToken != nil{
            dictionary["idToken"] = idToken
        }
        if refreshToken != nil{
            dictionary["refreshToken"] = refreshToken
        }
        if user != nil{
            dictionary["user"] = user.toDictionary()
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        idToken = aDecoder.decodeObject(forKey: "idToken") as? String
        refreshToken = aDecoder.decodeObject(forKey: "refreshToken") as? String
        user = aDecoder.decodeObject(forKey: "user") as? UserInfoUser
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if accessToken != nil{
            aCoder.encode(accessToken, forKey: "accessToken")
        }
        if idToken != nil{
            aCoder.encode(idToken, forKey: "idToken")
        }
        if refreshToken != nil{
            aCoder.encode(refreshToken, forKey: "refreshToken")
        }
        if user != nil{
            aCoder.encode(user, forKey: "user")
        }
        
    }
    
}
