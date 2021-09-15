//
//	PaymentModePayment.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class PaymentModePayment : NSObject, NSCoding{

	var bank : PaymentModeBank!
	var card : PaymentModeCard!
	var id : Int!
	var isdefault : Bool!
	var mode : String!
	var paymentType : String!
	var title : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		let bankJson = json["bank"]
		if !bankJson.isEmpty{
			bank = PaymentModeBank(fromJson: bankJson)
		}
		let cardJson = json["card"]
		if !cardJson.isEmpty{
			card = PaymentModeCard(fromJson: cardJson)
		}
		id = json["id"].intValue
		isdefault = json["isdefault"].boolValue
		mode = json["mode"].stringValue
		paymentType = json["payment_type"].stringValue
		title = json["title"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if bank != nil{
			dictionary["bank"] = bank.toDictionary()
		}
		if card != nil{
			dictionary["card"] = card.toDictionary()
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isdefault != nil{
			dictionary["isdefault"] = isdefault
		}
		if mode != nil{
			dictionary["mode"] = mode
		}
		if paymentType != nil{
			dictionary["payment_type"] = paymentType
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
         bank = aDecoder.decodeObject(forKey: "bank") as? PaymentModeBank
         card = aDecoder.decodeObject(forKey: "card") as? PaymentModeCard
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isdefault = aDecoder.decodeObject(forKey: "isdefault") as? Bool
         mode = aDecoder.decodeObject(forKey: "mode") as? String
         paymentType = aDecoder.decodeObject(forKey: "payment_type") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if bank != nil{
			aCoder.encode(bank, forKey: "bank")
		}
		if card != nil{
			aCoder.encode(card, forKey: "card")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isdefault != nil{
			aCoder.encode(isdefault, forKey: "isdefault")
		}
		if mode != nil{
			aCoder.encode(mode, forKey: "mode")
		}
		if paymentType != nil{
			aCoder.encode(paymentType, forKey: "payment_type")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}