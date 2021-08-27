//
//  BannerData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class BannerData {

	let Banner: [BannerModels]?

	init(_ json: JSON) {
		Banner = json["banner"].arrayValue.map { BannerModels($0) }
	}

}
