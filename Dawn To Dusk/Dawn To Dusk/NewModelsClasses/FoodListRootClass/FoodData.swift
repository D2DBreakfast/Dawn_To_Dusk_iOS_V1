//
//  FoodData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class FoodData {

	let currenctPage: Int?
	let lastPage: Int?
	let food: [FoodModels]?
	let meals: [MealsModels]?

	init(_ json: JSON) {
		currenctPage = json["currenct_page"].intValue
		lastPage = json["last_page"].intValue
		food = json["food"].arrayValue.map { FoodModels($0) }
		meals = json["meals"].arrayValue.map { MealsModels($0) }
	}

}
