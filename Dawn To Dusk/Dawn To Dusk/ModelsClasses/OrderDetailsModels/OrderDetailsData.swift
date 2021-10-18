//
//	OrderDetailsData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class OrderDetailsData : NSObject, NSCoding{

	var email : String!
	var fullName : String!
	var mobileNo : String!
	var orderDetails : [OrderDetailsOrderDetail]!
	var userId : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		email = json["email"].stringValue
		fullName = json["fullName"].stringValue
		mobileNo = json["mobileNo"].stringValue
		orderDetails = [OrderDetailsOrderDetail]()
		let orderDetailsArray = json["orderDetails"].arrayValue
		for orderDetailsJson in orderDetailsArray{
			let value = OrderDetailsOrderDetail(fromJson: orderDetailsJson)
			orderDetails.append(value)
		}
		userId = json["userId"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if email != nil{
			dictionary["email"] = email
		}
		if fullName != nil{
			dictionary["fullName"] = fullName
		}
		if mobileNo != nil{
			dictionary["mobileNo"] = mobileNo
		}
		if orderDetails != nil{
			var dictionaryElements = [[String:Any]]()
			for orderDetailsElement in orderDetails {
				dictionaryElements.append(orderDetailsElement.toDictionary())
			}
			dictionary["orderDetails"] = dictionaryElements
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
         email = aDecoder.decodeObject(forKey: "email") as? String
         fullName = aDecoder.decodeObject(forKey: "fullName") as? String
         mobileNo = aDecoder.decodeObject(forKey: "mobileNo") as? String
         orderDetails = aDecoder.decodeObject(forKey: "orderDetails") as? [OrderDetailsOrderDetail]
         userId = aDecoder.decodeObject(forKey: "userId") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if fullName != nil{
			aCoder.encode(fullName, forKey: "fullName")
		}
		if mobileNo != nil{
			aCoder.encode(mobileNo, forKey: "mobileNo")
		}
		if orderDetails != nil{
			aCoder.encode(orderDetails, forKey: "orderDetails")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}

	}

}