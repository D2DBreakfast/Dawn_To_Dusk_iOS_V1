//
//	CouponModels.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class CouponModels : NSObject, NSCoding{

	var code : String!
	var details : String!
	var discount : Float!
	var id : Int!
	var shortdesc : String!
	var terms : String!
	var title : String!
	var validdatetime : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		code = json["code"].stringValue
		details = json["details"].stringValue
		discount = json["discount"].floatValue
		id = json["id"].intValue
		shortdesc = json["shortdesc"].stringValue
		terms = json["terms"].stringValue
		title = json["title"].stringValue
		validdatetime = json["validdatetime"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if code != nil{
			dictionary["code"] = code
		}
		if details != nil{
			dictionary["details"] = details
		}
		if discount != nil{
			dictionary["discount"] = discount
		}
		if id != nil{
			dictionary["id"] = id
		}
		if shortdesc != nil{
			dictionary["shortdesc"] = shortdesc
		}
		if terms != nil{
			dictionary["terms"] = terms
		}
		if title != nil{
			dictionary["title"] = title
		}
		if validdatetime != nil{
			dictionary["validdatetime"] = validdatetime
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? String
         details = aDecoder.decodeObject(forKey: "details") as? String
         discount = aDecoder.decodeObject(forKey: "discount") as? Float
         id = aDecoder.decodeObject(forKey: "id") as? Int
         shortdesc = aDecoder.decodeObject(forKey: "shortdesc") as? String
         terms = aDecoder.decodeObject(forKey: "terms") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String
         validdatetime = aDecoder.decodeObject(forKey: "validdatetime") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if details != nil{
			aCoder.encode(details, forKey: "details")
		}
		if discount != nil{
			aCoder.encode(discount, forKey: "discount")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if shortdesc != nil{
			aCoder.encode(shortdesc, forKey: "shortdesc")
		}
		if terms != nil{
			aCoder.encode(terms, forKey: "terms")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if validdatetime != nil{
			aCoder.encode(validdatetime, forKey: "validdatetime")
		}

	}

}
