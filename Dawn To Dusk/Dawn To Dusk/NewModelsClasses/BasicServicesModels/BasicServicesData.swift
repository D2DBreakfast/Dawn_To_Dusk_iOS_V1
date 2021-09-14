//
//  BasicServicesData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 25, 2021
//
import Foundation
import SwiftyJSON

class BasicServicesData : NSObject, NSCoding{
    
    var address : String!
    var discount : Float!
    var message : String!
    var payment : String!
    var placeorder : [PlaceorderModels]!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        address = json["address"].stringValue
        discount = json["discount"].floatValue
        message = json["message"].stringValue
        payment = json["payment"].stringValue
        placeorder = [PlaceorderModels]()
        let placeorderArray = json["placeorder"].arrayValue
        for placeorderJson in placeorderArray{
            let value = PlaceorderModels.init(fromJson: placeorderJson)
            placeorder.append(value)
        }
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
        if discount != nil{
            dictionary["discount"] = discount
        }
        if message != nil{
            dictionary["message"] = message
        }
        if payment != nil{
            dictionary["payment"] = payment
        }
        if placeorder != nil{
            var dictionaryElements = [[String:Any]]()
            for placeorderElement in placeorder {
                dictionaryElements.append(placeorderElement.toDictionary())
            }
            dictionary["placeorder"] = dictionaryElements
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
         discount = aDecoder.decodeObject(forKey: "discount") as? Float
         message = aDecoder.decodeObject(forKey: "message") as? String
         payment = aDecoder.decodeObject(forKey: "payment") as? String
         placeorder = aDecoder.decodeObject(forKey: "placeorder") as? [PlaceorderModels]

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
        if discount != nil{
            aCoder.encode(discount, forKey: "discount")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if payment != nil{
            aCoder.encode(payment, forKey: "payment")
        }
        if placeorder != nil{
            aCoder.encode(placeorder, forKey: "placeorder")
        }

    }

}
