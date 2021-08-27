//
//  PlaceorderModels.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class PlaceorderModels {

	let orderid: Int?
	let paymentStatus: String?

	init(_ json: JSON) {
		orderid = json["orderid"].intValue
		paymentStatus = json["payment_status"].stringValue
	}

}
