//
//	UserInfoAddresData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class UserInfoAddresData : NSObject, NSCoding{
    
    var address : [UserInfoAddres]!
    var community : [UserInfoCommunity]!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        address = [UserInfoAddres]()
        let addressArray = json["address"].arrayValue
        for addressJson in addressArray{
            let value = UserInfoAddres(fromJson: addressJson)
            address.append(value)
        }
        community = [UserInfoCommunity]()
        let comArray = json["community"].arrayValue
        for comJson in comArray{
            let value = UserInfoCommunity(fromJson: comJson)
            community.append(value)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if address != nil{
            var dictionaryElements = [[String:Any]]()
            for addressElement in address {
                dictionaryElements.append(addressElement.toDictionary())
            }
            dictionary["address"] = dictionaryElements
        }
        if community != nil{
            var dictionaryElements = [[String:Any]]()
            for comElement in community {
                dictionaryElements.append(comElement.toDictionary())
            }
            dictionary["community"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        address = aDecoder.decodeObject(forKey: "address") as? [UserInfoAddres]
        community = aDecoder.decodeObject(forKey: "community") as? [UserInfoCommunity]
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
    }
    
}
