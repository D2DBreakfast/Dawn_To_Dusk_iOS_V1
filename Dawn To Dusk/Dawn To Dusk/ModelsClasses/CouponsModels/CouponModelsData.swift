//
//    CouponModelsData.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class CouponModelsData : NSObject, NSCoding{

    var coupon : [CouponModels]!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        coupon = [CouponModels]()
        let couponArray = json["coupons"].arrayValue
        for couponJson in couponArray{
            let value = CouponModels(fromJson: couponJson)
            coupon.append(value)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if coupon != nil{
            var dictionaryElements = [[String:Any]]()
            for couponElement in coupon {
                dictionaryElements.append(couponElement.toDictionary())
            }
            dictionary["coupons"] = dictionaryElements
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         coupon = aDecoder.decodeObject(forKey: "coupons") as? [CouponModels]

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if coupon != nil{
            aCoder.encode(coupon, forKey: "coupons")
        }

    }

}
