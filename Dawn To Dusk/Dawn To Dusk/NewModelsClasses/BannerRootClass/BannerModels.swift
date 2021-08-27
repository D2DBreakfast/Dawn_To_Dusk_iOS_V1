//
//  BannerModels.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class BannerModels {

	let id: Int?
	let bannerName: String?
	let bannerImage: String?
	let bannerDes: String?
	let bannerTitle: String?

	init(_ json: JSON) {
		id = json["id"].intValue
		bannerName = json["banner_name"].stringValue
		bannerImage = json["banner_image"].stringValue
		bannerDes = json["banner_des"].stringValue
		bannerTitle = json["banner_title"].stringValue
	}

}
