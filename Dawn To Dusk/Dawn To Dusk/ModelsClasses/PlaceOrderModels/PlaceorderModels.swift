//
//  PlaceorderModels.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class PlaceorderModels : NSObject, NSCoding {
    
    var orderid : Int!
    var paymentStatus : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        orderid = json["orderid"].intValue
        paymentStatus = json["paymentStatus"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if orderid != nil{
            dictionary["orderid"] = orderid
        }
        if paymentStatus != nil{
            dictionary["paymentStatus"] = paymentStatus
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         orderid = aDecoder.decodeObject(forKey: "orderid") as? Int
         paymentStatus = aDecoder.decodeObject(forKey: "paymentStatus") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if orderid != nil{
            aCoder.encode(orderid, forKey: "orderid")
        }
        if paymentStatus != nil{
            aCoder.encode(paymentStatus, forKey: "paymentStatus")
        }

    }

}
