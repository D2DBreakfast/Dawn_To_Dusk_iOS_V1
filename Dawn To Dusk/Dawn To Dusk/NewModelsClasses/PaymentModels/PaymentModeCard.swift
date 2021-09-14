//
//	PaymentModeCard.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class PaymentModeCard : NSObject, NSCoding{

	var cardType : String!
	var cardno : String!
	var id : Int!
	var month : String!
	var name : String!
	var subcardType : String!
	var year : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		cardType = json["card_type"].stringValue
		cardno = json["cardno"].stringValue
		id = json["id"].intValue
		month = json["month"].stringValue
		name = json["name"].stringValue
		subcardType = json["subcard_type"].stringValue
		year = json["year"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if cardType != nil{
			dictionary["card_type"] = cardType
		}
		if cardno != nil{
			dictionary["cardno"] = cardno
		}
		if id != nil{
			dictionary["id"] = id
		}
		if month != nil{
			dictionary["month"] = month
		}
		if name != nil{
			dictionary["name"] = name
		}
		if subcardType != nil{
			dictionary["subcard_type"] = subcardType
		}
		if year != nil{
			dictionary["year"] = year
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cardType = aDecoder.decodeObject(forKey: "card_type") as? String
         cardno = aDecoder.decodeObject(forKey: "cardno") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         month = aDecoder.decodeObject(forKey: "month") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         subcardType = aDecoder.decodeObject(forKey: "subcard_type") as? String
         year = aDecoder.decodeObject(forKey: "year") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if cardType != nil{
			aCoder.encode(cardType, forKey: "card_type")
		}
		if cardno != nil{
			aCoder.encode(cardno, forKey: "cardno")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if month != nil{
			aCoder.encode(month, forKey: "month")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if subcardType != nil{
			aCoder.encode(subcardType, forKey: "subcard_type")
		}
		if year != nil{
			aCoder.encode(year, forKey: "year")
		}

	}

}