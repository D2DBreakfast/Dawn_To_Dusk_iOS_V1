//
//	PaymentModeData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class PaymentModeData : NSObject, NSCoding{

	var payment : [PaymentModePayment]!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		payment = [PaymentModePayment]()
		let paymentArray = json["payment"].arrayValue
		for paymentJson in paymentArray{
			let value = PaymentModePayment(fromJson: paymentJson)
			payment.append(value)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if payment != nil{
			var dictionaryElements = [[String:Any]]()
			for paymentElement in payment {
				dictionaryElements.append(paymentElement.toDictionary())
			}
			dictionary["payment"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         payment = aDecoder.decodeObject(forKey: "payment") as? [PaymentModePayment]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if payment != nil{
			aCoder.encode(payment, forKey: "payment")
		}

	}

}