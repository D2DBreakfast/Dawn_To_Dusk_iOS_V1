//
//	OrderHistoryData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class OrderHistoryData : NSObject, NSCoding{
    
    var community : UserInfoCommunity!
    var coupon : CouponModels!
    var datetime : String!
    var deliveryDate : String!
    var deliveryaddress : UserInfoAddres!
    var id : Int!
    var invoice : String!
    var invoiceURL : String!
    var ordersitems : [FoodModels]!
    var mealsitems : [MealsModels]!
    var orderid : Int!
    var orderstatus : String!
    var paybleamount : Float!
    var paymentmode : PaymentModePayment!
    var review : OrderHistoryReview!
    var title : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let communityJson = json["community"]
        if !communityJson.isEmpty{
            community = UserInfoCommunity(fromJson: communityJson)
        }
        let couponJson = json["coupon"]
        if !couponJson.isEmpty{
            coupon = CouponModels(fromJson: couponJson)
        }
        datetime = json["datetime"].stringValue
        deliveryDate = json["delivery_date"].stringValue
        let deliveryaddressJson = json["deliveryaddress"]
        if !deliveryaddressJson.isEmpty{
            deliveryaddress = UserInfoAddres(fromJson: deliveryaddressJson)
        }
        id = json["id"].intValue
        invoice = json["invoice"].stringValue
        invoiceURL = json["invoiceURL"].stringValue
        ordersitems = [FoodModels]()
        let orderArray = json["orders"].arrayValue
        for orderJson in orderArray{
            let value = FoodModels(fromJson: orderJson)
            ordersitems.append(value)
        }
        mealsitems = [MealsModels]()
        let mealsArray = json["meals"].arrayValue
        for mealsJson in mealsArray{
            let value = MealsModels(fromJson: mealsJson)
            mealsitems.append(value)
        }
        orderid = json["orderid"].intValue
        orderstatus = json["orderstatus"].stringValue
        paybleamount = json["paybleamount"].floatValue
        let paymentmodeJson = json["paymentmode"]
        if !paymentmodeJson.isEmpty{
            paymentmode = PaymentModePayment(fromJson: paymentmodeJson)
        }
        let reviewJson = json["review"]
        if !reviewJson.isEmpty{
            review = OrderHistoryReview(fromJson: reviewJson)
        }
        title = json["title"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if community != nil{
            dictionary["community"] = community.toDictionary()
        }
        if coupon != nil{
            dictionary["coupon"] = coupon.toDictionary()
        }
        if datetime != nil{
            dictionary["datetime"] = datetime
        }
        if deliveryDate != nil{
            dictionary["delivery_date"] = deliveryDate
        }
        if deliveryaddress != nil{
            dictionary["deliveryaddress"] = deliveryaddress.toDictionary()
        }
        if id != nil{
            dictionary["id"] = id
        }
        if invoice != nil{
            dictionary["invoice"] = invoice
        }
        if invoiceURL != nil{
            dictionary["invoiceURL"] = invoiceURL
        }
        if ordersitems != nil{
            var dictionaryElements = [[String:Any]]()
            for orderElement in ordersitems {
                dictionaryElements.append(orderElement.toDictionary())
            }
            dictionary["orders"] = dictionaryElements
        }
        if mealsitems != nil{
            var dictionaryElements = [[String:Any]]()
            for mealsElement in mealsitems {
                dictionaryElements.append(mealsElement.toDictionary())
            }
            dictionary["meals"] = dictionaryElements
        }
        if orderid != nil{
            dictionary["orderid"] = orderid
        }
        if orderstatus != nil{
            dictionary["orderstatus"] = orderstatus
        }
        if paybleamount != nil{
            dictionary["paybleamount"] = paybleamount
        }
        if paymentmode != nil{
            dictionary["paymentmode"] = paymentmode.toDictionary()
        }
        if review != nil{
            dictionary["review"] = review.toDictionary()
        }
        if title != nil{
            dictionary["title"] = title
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        community = aDecoder.decodeObject(forKey: "community") as? UserInfoCommunity
        coupon = aDecoder.decodeObject(forKey: "coupon") as? CouponModels
        datetime = aDecoder.decodeObject(forKey: "datetime") as? String
        deliveryDate = aDecoder.decodeObject(forKey: "delivery_date") as? String
        deliveryaddress = aDecoder.decodeObject(forKey: "deliveryaddress") as? UserInfoAddres
        id = aDecoder.decodeObject(forKey: "id") as? Int
        invoice = aDecoder.decodeObject(forKey: "invoice") as? String
        invoiceURL = aDecoder.decodeObject(forKey: "invoiceURL") as? String
        ordersitems = aDecoder.decodeObject(forKey: "orders") as? [FoodModels]
        mealsitems = aDecoder.decodeObject(forKey: "meals") as? [MealsModels]
        orderid = aDecoder.decodeObject(forKey: "orderid") as? Int
        orderstatus = aDecoder.decodeObject(forKey: "orderstatus") as? String
        paybleamount = aDecoder.decodeObject(forKey: "paybleamount") as? Float
        paymentmode = aDecoder.decodeObject(forKey: "paymentmode") as? PaymentModePayment
        review = aDecoder.decodeObject(forKey: "review") as? OrderHistoryReview
        title = aDecoder.decodeObject(forKey: "title") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if community != nil{
            aCoder.encode(community, forKey: "community")
        }
        if coupon != nil{
            aCoder.encode(coupon, forKey: "coupon")
        }
        if datetime != nil{
            aCoder.encode(datetime, forKey: "datetime")
        }
        if deliveryDate != nil{
            aCoder.encode(deliveryDate, forKey: "delivery_date")
        }
        if deliveryaddress != nil{
            aCoder.encode(deliveryaddress, forKey: "deliveryaddress")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if invoice != nil{
            aCoder.encode(invoice, forKey: "invoice")
        }
        if invoiceURL != nil{
            aCoder.encode(invoiceURL, forKey: "invoiceURL")
        }
        if ordersitems != nil{
            aCoder.encode(ordersitems, forKey: "orders")
        }
        if mealsitems != nil{
            aCoder.encode(mealsitems, forKey: "meals")
        }
        if orderid != nil{
            aCoder.encode(orderid, forKey: "orderid")
        }
        if orderstatus != nil{
            aCoder.encode(orderstatus, forKey: "orderstatus")
        }
        if paybleamount != nil{
            aCoder.encode(paybleamount, forKey: "paybleamount")
        }
        if paymentmode != nil{
            aCoder.encode(paymentmode, forKey: "paymentmode")
        }
        if review != nil{
            aCoder.encode(review, forKey: "review")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        
    }
    
}
