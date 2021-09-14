//
//	UserInfoAddresAddres.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class UserInfoAddres : NSObject, NSCoding{

	var address : String!
	var addresstype : String!
	var id : Int!
	var isprimary : Bool!
	var lat : Double!
	var longField : Double!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		address = json["address"].stringValue
		addresstype = json["addresstype"].stringValue
		id = json["id"].intValue
		isprimary = json["isprimary"].boolValue
		lat = json["lat"].doubleValue
		longField = json["long"].doubleValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if address != nil{
			dictionary["address"] = address
		}
		if addresstype != nil{
			dictionary["addresstype"] = addresstype
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isprimary != nil{
			dictionary["isprimary"] = isprimary
		}
		if lat != nil{
			dictionary["lat"] = lat
		}
		if longField != nil{
			dictionary["long"] = longField
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         address = aDecoder.decodeObject(forKey: "address") as? String
         addresstype = aDecoder.decodeObject(forKey: "addresstype") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isprimary = aDecoder.decodeObject(forKey: "isprimary") as? Bool
         lat = aDecoder.decodeObject(forKey: "lat") as? Double
         longField = aDecoder.decodeObject(forKey: "long") as? Double

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if addresstype != nil{
			aCoder.encode(addresstype, forKey: "addresstype")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isprimary != nil{
			aCoder.encode(isprimary, forKey: "isprimary")
		}
		if lat != nil{
			aCoder.encode(lat, forKey: "lat")
		}
		if longField != nil{
			aCoder.encode(longField, forKey: "long")
		}

	}

}
