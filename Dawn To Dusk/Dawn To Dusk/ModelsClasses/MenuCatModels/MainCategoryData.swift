//
//	MenuCategoryMainCategoryData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class MainCategoryData : NSObject, NSCoding{
    
    var id : Double!
    var mainCategoryId : String!
    var mainCategoryName : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].doubleValue
        mainCategoryId = json["mainCategoryId"].stringValue
        mainCategoryName = json["mainCategoryName"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["_id"] = id
        }
        if mainCategoryId != nil{
            dictionary["mainCategoryId"] = mainCategoryId
        }
        if mainCategoryName != nil{
            dictionary["mainCategoryName"] = mainCategoryName
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "_id") as? Double
        mainCategoryId = aDecoder.decodeObject(forKey: "mainCategoryId") as? String
        mainCategoryName = aDecoder.decodeObject(forKey: "mainCategoryName") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if mainCategoryId != nil{
            aCoder.encode(mainCategoryId, forKey: "mainCategoryId")
        }
        if mainCategoryName != nil{
            aCoder.encode(mainCategoryName, forKey: "mainCategoryName")
        }
        
    }
    
}
