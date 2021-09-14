//
//    CategoryModels.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class CategoryModels : NSObject, NSCoding{

    var catName : String!
    var id : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        catName = json["cat_name"].stringValue
        id = json["id"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if catName != nil{
            dictionary["cat_name"] = catName
        }
        if id != nil{
            dictionary["id"] = id
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         catName = aDecoder.decodeObject(forKey: "cat_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if catName != nil{
            aCoder.encode(catName, forKey: "cat_name")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }

    }

}
