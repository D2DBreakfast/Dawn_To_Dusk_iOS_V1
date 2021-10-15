//
//	UserInfoUser.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class UserInfoUser : NSObject, NSCoding {
    
    var countryCode : String!
    var email : String!
    var fullName : String!
    var mobileNo : String!
    var mobileOtp : String!
    var registerDate : String!
    var token : String!
    var userId : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        countryCode = json["countryCode"].stringValue
        email = json["email"].stringValue
        fullName = json["fullName"].stringValue
        mobileNo = json["mobileNo"].stringValue
        mobileOtp = json["mobileOtp"].stringValue
        registerDate = json["registerDate"].stringValue
        token = json["token"].stringValue
        userId = json["userId"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if countryCode != nil{
            dictionary["countryCode"] = countryCode
        }
        if email != nil{
            dictionary["email"] = email
        }
        if fullName != nil{
            dictionary["fullName"] = fullName
        }
        if mobileNo != nil{
            dictionary["mobileNo"] = mobileNo
        }
        if mobileOtp != nil{
            dictionary["mobileOtp"] = mobileOtp
        }
        if registerDate != nil{
            dictionary["registerDate"] = registerDate
        }
        if token != nil{
            dictionary["token"] = token
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         countryCode = aDecoder.decodeObject(forKey: "countryCode") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         fullName = aDecoder.decodeObject(forKey: "fullName") as? String
         mobileNo = aDecoder.decodeObject(forKey: "mobileNo") as? String
         mobileOtp = aDecoder.decodeObject(forKey: "mobileOtp") as? String
         registerDate = aDecoder.decodeObject(forKey: "registerDate") as? String
         token = aDecoder.decodeObject(forKey: "token") as? String
         userId = aDecoder.decodeObject(forKey: "userId") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if countryCode != nil{
            aCoder.encode(countryCode, forKey: "countryCode")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if fullName != nil{
            aCoder.encode(fullName, forKey: "fullName")
        }
        if mobileNo != nil{
            aCoder.encode(mobileNo, forKey: "mobileNo")
        }
        if mobileOtp != nil{
            aCoder.encode(mobileOtp, forKey: "mobileOtp")
        }
        if registerDate != nil{
            aCoder.encode(registerDate, forKey: "registerDate")
        }
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }

    }

}
