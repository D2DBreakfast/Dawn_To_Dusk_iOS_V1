//
//	MyCartCartData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class MyCartCartData : NSObject, NSCoding{

	var itemId : String!
	var itemMainCategoryName : String!
	var itemName : String!
	var itemPrice : String!
	var itemQuantity : String!
	var itemSubCategoryName : String!
	var orderDate : String!
	var orderId : String!
	var orderStatus : String!
	var userId : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		itemId = json["itemId"].stringValue
		itemMainCategoryName = json["itemMainCategoryName"].stringValue
		itemName = json["itemName"].stringValue
		itemPrice = json["itemPrice"].stringValue
		itemQuantity = json["itemQuantity"].stringValue
		itemSubCategoryName = json["itemSubCategoryName"].stringValue
		orderDate = json["orderDate"].stringValue
		orderId = json["orderId"].stringValue
		orderStatus = json["orderStatus"].stringValue
		userId = json["userId"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if itemId != nil{
			dictionary["itemId"] = itemId
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
		if orderDate != nil{
			dictionary["orderDate"] = orderDate
		}
		if orderId != nil{
			dictionary["orderId"] = orderId
		}
		if orderStatus != nil{
			dictionary["orderStatus"] = orderStatus
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
         itemId = aDecoder.decodeObject(forKey: "itemId") as? String
         itemMainCategoryName = aDecoder.decodeObject(forKey: "itemMainCategoryName") as? String
         itemName = aDecoder.decodeObject(forKey: "itemName") as? String
         itemPrice = aDecoder.decodeObject(forKey: "itemPrice") as? String
         itemQuantity = aDecoder.decodeObject(forKey: "itemQuantity") as? String
         itemSubCategoryName = aDecoder.decodeObject(forKey: "itemSubCategoryName") as? String
         orderDate = aDecoder.decodeObject(forKey: "orderDate") as? String
         orderId = aDecoder.decodeObject(forKey: "orderId") as? String
         orderStatus = aDecoder.decodeObject(forKey: "orderStatus") as? String
         userId = aDecoder.decodeObject(forKey: "userId") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if itemId != nil{
			aCoder.encode(itemId, forKey: "itemId")
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
		if orderDate != nil{
			aCoder.encode(orderDate, forKey: "orderDate")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "orderId")
		}
		if orderStatus != nil{
			aCoder.encode(orderStatus, forKey: "orderStatus")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}

	}

}