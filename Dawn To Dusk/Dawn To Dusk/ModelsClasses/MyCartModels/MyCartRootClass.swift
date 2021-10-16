//
//	MyCartRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class MyCartRootClass : NSObject, NSCoding{

	var cartData : [MyCartCartData]!
	var message : String!
	var status : Bool!
	var statusCode : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		cartData = [MyCartCartData]()
		let cartDataArray = json["cartData"].arrayValue
		for cartDataJson in cartDataArray{
			let value = MyCartCartData(fromJson: cartDataJson)
			cartData.append(value)
		}
		message = json["message"].stringValue
		status = json["status"].boolValue
		statusCode = json["statusCode"].intValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if cartData != nil{
			var dictionaryElements = [[String:Any]]()
			for cartDataElement in cartData {
				dictionaryElements.append(cartDataElement.toDictionary())
			}
			dictionary["cartData"] = dictionaryElements
		}
		if message != nil{
			dictionary["message"] = message
		}
		if status != nil{
			dictionary["status"] = status
		}
		if statusCode != nil{
			dictionary["statusCode"] = statusCode
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cartData = aDecoder.decodeObject(forKey: "cartData") as? [MyCartCartData]
         message = aDecoder.decodeObject(forKey: "message") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Bool
         statusCode = aDecoder.decodeObject(forKey: "statusCode") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if cartData != nil{
			aCoder.encode(cartData, forKey: "cartData")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if statusCode != nil{
			aCoder.encode(statusCode, forKey: "statusCode")
		}

	}

}