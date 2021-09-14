//
//	UserInfoUser.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class UserInfoUser : NSObject, NSCoding{
    
    var address : UserInfoAddres!
    var community : UserInfoCommunity!
    var countrycode : String!
    var email : String!
    var fullname : String!
    var id : Int!
    var mobile : String!
    var paymentmode : PaymentModePayment!
    var profileimg : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let addressJson = json["address"]
        if !addressJson.isEmpty{
            address = UserInfoAddres(fromJson: addressJson)
        }
        let communityJson = json["community"]
        if !communityJson.isEmpty{
            community = UserInfoCommunity(fromJson: communityJson)
        }
        countrycode = json["countrycode"].stringValue
        email = json["email"].stringValue
        fullname = json["fullname"].stringValue
        id = json["id"].intValue
        mobile = json["mobile"].stringValue
        let paymentmodeJson = json["paymentmode"]
        if !paymentmodeJson.isEmpty{
            paymentmode = PaymentModePayment(fromJson: paymentmodeJson)
        }
        profileimg = json["profileimg"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if address != nil{
            dictionary["address"] = address.toDictionary()
        }
        if community != nil{
            dictionary["community"] = community.toDictionary()
        }
        if countrycode != nil{
            dictionary["countrycode"] = countrycode
        }
        if email != nil{
            dictionary["email"] = email
        }
        if fullname != nil{
            dictionary["fullname"] = fullname
        }
        if id != nil{
            dictionary["id"] = id
        }
        if mobile != nil{
            dictionary["mobile"] = mobile
        }
        if paymentmode != nil{
            dictionary["paymentmode"] = paymentmode.toDictionary()
        }
        if profileimg != nil{
            dictionary["profileimg"] = profileimg
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        address = aDecoder.decodeObject(forKey: "address") as? UserInfoAddres
        community = aDecoder.decodeObject(forKey: "community") as? UserInfoCommunity
        countrycode = aDecoder.decodeObject(forKey: "countrycode") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        fullname = aDecoder.decodeObject(forKey: "fullname") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        paymentmode = aDecoder.decodeObject(forKey: "paymentmode") as? PaymentModePayment
        profileimg = aDecoder.decodeObject(forKey: "profileimg") as? String
        
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
        if community != nil{
            aCoder.encode(community, forKey: "community")
        }
        if countrycode != nil{
            aCoder.encode(countrycode, forKey: "countrycode")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if fullname != nil{
            aCoder.encode(fullname, forKey: "fullname")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if mobile != nil{
            aCoder.encode(mobile, forKey: "mobile")
        }
        if paymentmode != nil{
            aCoder.encode(paymentmode, forKey: "paymentmode")
        }
        if profileimg != nil{
            aCoder.encode(profileimg, forKey: "profileimg")
        }
        
    }
    
}
