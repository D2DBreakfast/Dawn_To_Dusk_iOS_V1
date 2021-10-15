//
//    MenuItemsData.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class MenuItemsData : NSObject, NSCoding{

    var id : String!
    var itemDescription : String!
    var itemFoodType : String!
    var itemId : String!
    var itemImageUrl : String!
    var itemMainCategoryName : String!
    var itemName : String!
    var itemPrice : String!
    var itemQuantity : String!
    var itemSubCategoryName : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        itemDescription = json["itemDescription"].stringValue
        itemFoodType = json["itemFoodType"].stringValue
        itemId = json["itemId"].stringValue
        itemImageUrl = json["itemImageUrl"].stringValue
        itemMainCategoryName = json["itemMainCategoryName"].stringValue
        itemName = json["itemName"].stringValue
        itemPrice = json["itemPrice"].stringValue
        itemQuantity = json["itemQuantity"].stringValue
        itemSubCategoryName = json["itemSubCategoryName"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["_id"] = id
        }
        if itemDescription != nil{
            dictionary["itemDescription"] = itemDescription
        }
        if itemFoodType != nil{
            dictionary["itemFoodType"] = itemFoodType
        }
        if itemId != nil{
            dictionary["itemId"] = itemId
        }
        if itemImageUrl != nil{
            dictionary["itemImageUrl"] = itemImageUrl
        }
        if itemMainCategoryName != nil{
            dictionary["itemMainCategoryName"] = itemMainCategoryName
        }
        if itemName != nil{
            dictionary["itemName"] = itemName
        }
        if itemPrice != nil{
            dictionary["itemPrice"] = itemPrice
        }
        if itemQuantity != nil{
            dictionary["itemQuantity"] = itemQuantity
        }
        if itemSubCategoryName != nil{
            dictionary["itemSubCategoryName"] = itemSubCategoryName
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         id = aDecoder.decodeObject(forKey: "_id") as? String
         itemDescription = aDecoder.decodeObject(forKey: "itemDescription") as? String
         itemFoodType = aDecoder.decodeObject(forKey: "itemFoodType") as? String
         itemId = aDecoder.decodeObject(forKey: "itemId") as? String
         itemImageUrl = aDecoder.decodeObject(forKey: "itemImageUrl") as? String
         itemMainCategoryName = aDecoder.decodeObject(forKey: "itemMainCategoryName") as? String
         itemName = aDecoder.decodeObject(forKey: "itemName") as? String
         itemPrice = aDecoder.decodeObject(forKey: "itemPrice") as? String
         itemQuantity = aDecoder.decodeObject(forKey: "itemQuantity") as? String
         itemSubCategoryName = aDecoder.decodeObject(forKey: "itemSubCategoryName") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if itemDescription != nil{
            aCoder.encode(itemDescription, forKey: "itemDescription")
        }
        if itemFoodType != nil{
            aCoder.encode(itemFoodType, forKey: "itemFoodType")
        }
        if itemId != nil{
            aCoder.encode(itemId, forKey: "itemId")
        }
        if itemImageUrl != nil{
            aCoder.encode(itemImageUrl, forKey: "itemImageUrl")
        }
        if itemMainCategoryName != nil{
            aCoder.encode(itemMainCategoryName, forKey: "itemMainCategoryName")
        }
        if itemName != nil{
            aCoder.encode(itemName, forKey: "itemName")
        }
        if itemPrice != nil{
            aCoder.encode(itemPrice, forKey: "itemPrice")
        }
        if itemQuantity != nil{
            aCoder.encode(itemQuantity, forKey: "itemQuantity")
        }
        if itemSubCategoryName != nil{
            aCoder.encode(itemSubCategoryName, forKey: "itemSubCategoryName")
        }

    }

}
