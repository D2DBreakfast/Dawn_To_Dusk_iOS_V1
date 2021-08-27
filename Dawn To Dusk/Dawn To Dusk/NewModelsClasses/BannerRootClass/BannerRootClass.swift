//
//  BannerRootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class BannerRootClass {

	let Status: Bool?
	let Code: Int?
	let message: String?
	let Data: BannerData?

	init(_ json: JSON) {
		Status = json["status"].boolValue
		Code = json["code"].intValue
		message = json["message"].stringValue
		Data = BannerData(json["data"])
	}

}
