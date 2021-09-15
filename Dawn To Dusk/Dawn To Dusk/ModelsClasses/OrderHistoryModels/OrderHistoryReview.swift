//
//	OrderHistoryReview.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class OrderHistoryReview : NSObject, NSCoding{

	var comments : String!
	var rating : Float!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		comments = json["comments"].stringValue
		rating = json["rating"].floatValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if comments != nil{
			dictionary["comments"] = comments
		}
		if rating != nil{
			dictionary["rating"] = rating
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         comments = aDecoder.decodeObject(forKey: "comments") as? String
         rating = aDecoder.decodeObject(forKey: "rating") as? Float

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if comments != nil{
			aCoder.encode(comments, forKey: "comments")
		}
		if rating != nil{
			aCoder.encode(rating, forKey: "rating")
		}

	}

}
