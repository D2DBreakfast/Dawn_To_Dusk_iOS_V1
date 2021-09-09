//
//	PaymentModeBank.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class PaymentModeBank : NSObject, NSCoding{

	var accountno : String!
	var bankCode : String!
	var bankName : String!
	var id : Int!
	var ifcsCode : String!
	var name : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		accountno = json["accountno"].stringValue
		bankCode = json["bank_code"].stringValue
		bankName = json["bank_name"].stringValue
		id = json["id"].intValue
		ifcsCode = json["ifcs_code"].stringValue
		name = json["name"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if accountno != nil{
			dictionary["accountno"] = accountno
		}
		if bankCode != nil{
			dictionary["bank_code"] = bankCode
		}
		if bankName != nil{
			dictionary["bank_name"] = bankName
		}
		if id != nil{
			dictionary["id"] = id
		}
		if ifcsCode != nil{
			dictionary["ifcs_code"] = ifcsCode
		}
		if name != nil{
			dictionary["name"] = name
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         accountno = aDecoder.decodeObject(forKey: "accountno") as? String
         bankCode = aDecoder.decodeObject(forKey: "bank_code") as? String
         bankName = aDecoder.decodeObject(forKey: "bank_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         ifcsCode = aDecoder.decodeObject(forKey: "ifcs_code") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if accountno != nil{
			aCoder.encode(accountno, forKey: "accountno")
		}
		if bankCode != nil{
			aCoder.encode(bankCode, forKey: "bank_code")
		}
		if bankName != nil{
			aCoder.encode(bankName, forKey: "bank_name")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if ifcsCode != nil{
			aCoder.encode(ifcsCode, forKey: "ifcs_code")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}

	}

}