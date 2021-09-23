//
//    FoodData.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class FoodData : NSObject, NSCoding{
    
    var currenctPage : Int!
    var lastPage : Int!
    var paybleamount : String!
    var orders : [FoodModels]!
    var meals : [MealsModels]!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        currenctPage = json["currenct_page"].intValue
        lastPage = json["last_page"].intValue
        paybleamount = json["paybleamount"].stringValue
        orders = [FoodModels]()
        let orderArray = json["orders"].arrayValue
        for orderJson in orderArray{
            let value = FoodModels(fromJson: orderJson)
            orders.append(value)
        }
        meals = [MealsModels]()
        let mealsArray = json["meals"].arrayValue
        for mealsJson in mealsArray{
            let value = MealsModels(fromJson: mealsJson)
            meals.append(value)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if currenctPage != nil{
            dictionary["currenct_page"] = currenctPage
        }
        if lastPage != nil{
            dictionary["last_page"] = lastPage
        }
        if paybleamount != nil{
            dictionary["paybleamount"] = paybleamount
        }
        if orders != nil{
            var dictionaryElements = [[String:Any]]()
            for orderElement in orders {
                dictionaryElements.append(orderElement.toDictionary())
            }
            dictionary["orders"] = dictionaryElements
        }
        if meals != nil{
            var dictionaryElements = [[String:Any]]()
            for mealsElement in meals {
                dictionaryElements.append(mealsElement.toDictionary())
            }
            dictionary["meals"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        currenctPage = aDecoder.decodeObject(forKey: "currenct_page") as? Int
        lastPage = aDecoder.decodeObject(forKey: "last_page") as? Int
        paybleamount = aDecoder.decodeObject(forKey: "paybleamount") as? String
        orders = aDecoder.decodeObject(forKey: "orders") as? [FoodModels]
        meals = aDecoder.decodeObject(forKey: "meals") as? [MealsModels]
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if currenctPage != nil{
            aCoder.encode(currenctPage, forKey: "currenct_page")
        }
        if lastPage != nil{
            aCoder.encode(lastPage, forKey: "last_page")
        }
        if paybleamount != nil{
            aCoder.encode(paybleamount, forKey: "paybleamount")
        }
        if orders != nil{
            aCoder.encode(orders, forKey: "orders")
        }
        if meals != nil{
            aCoder.encode(meals, forKey: "meals")
        }
        
    }
    
}
