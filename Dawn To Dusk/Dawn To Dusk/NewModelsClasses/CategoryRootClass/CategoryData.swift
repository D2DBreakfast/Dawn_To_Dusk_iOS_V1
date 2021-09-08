//
//    CategoryData.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class CategoryData : NSObject, NSCoding{

    var category : [CategoryModels]!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        category = [CategoryModels]()
        let categoryArray = json["category"].arrayValue
        for categoryJson in categoryArray{
            let value = CategoryModels(fromJson: categoryJson)
            category.append(value)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if category != nil{
            var dictionaryElements = [[String:Any]]()
            for categoryElement in category {
                dictionaryElements.append(categoryElement.toDictionary())
            }
            dictionary["category"] = dictionaryElements
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         category = aDecoder.decodeObject(forKey: "category") as? [CategoryModels]

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }

    }

}
