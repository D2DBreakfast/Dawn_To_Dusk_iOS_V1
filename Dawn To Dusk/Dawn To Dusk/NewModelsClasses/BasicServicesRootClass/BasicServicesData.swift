//
//  BasicServicesData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class BasicServicesData {
    
    let payment: String?
    let address: String?
    let discount: Double?
    let placeorder: PlaceorderModels?
    let message: String?
    
    init(_ json: JSON) {
        payment = json["payment"].stringValue
        address = json["address"].stringValue
        discount = json["discount"].doubleValue
        placeorder = PlaceorderModels(json["placeorder"])
        message = json["message"].stringValue
    }
    
}
