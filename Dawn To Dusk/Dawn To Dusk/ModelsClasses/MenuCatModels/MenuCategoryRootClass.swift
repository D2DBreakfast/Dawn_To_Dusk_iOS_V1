//
//	MenuCategoryRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class MenuCategoryRootClass : NSObject, NSCoding{
    
    var mainCategoryData : [MainCategoryData]!
    var subCategoryData : [SubCategoryData]!
    var message : String!
    var status : Bool!
    var statusCode : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        mainCategoryData = [MainCategoryData]()
        let mainCategoryDataArray = json["mainCategoryData"].arrayValue
        for mainCategoryDataJson in mainCategoryDataArray{
            let value = MainCategoryData(fromJson: mainCategoryDataJson)
            mainCategoryData.append(value)
        }
        subCategoryData = [SubCategoryData]()
        let subCategoryDataArray = json["subCategoryData"].arrayValue
        for subCategoryDataJson in subCategoryDataArray{
            let value = SubCategoryData(fromJson: subCategoryDataJson)
            subCategoryData.append(value)
        }
        message = json["message"].stringValue
        status = json["status"].boolValue
        statusCode = json["statusCode"].intValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if mainCategoryData != nil{
            var dictionaryElements = [[String:Any]]()
            for mainCategoryDataElement in mainCategoryData {
                dictionaryElements.append(mainCategoryDataElement.toDictionary())
            }
            dictionary["mainCategoryData"] = dictionaryElements
        }
        if subCategoryData != nil{
            var dictionaryElements = [[String:Any]]()
            for subCategoryDataElement in subCategoryData {
                dictionaryElements.append(subCategoryDataElement.toDictionary())
            }
            dictionary["subCategoryData"] = dictionaryElements
        }
        if message != nil{
            dictionary["message"] = message
        }
        if status != nil{
            dictionary["status"] = status
        }
        if statusCode != nil{
            dictionary["statusCode"] = statusCode
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        mainCategoryData = aDecoder.decodeObject(forKey: "mainCategoryData") as? [MainCategoryData]
        subCategoryData = aDecoder.decodeObject(forKey: "subCategoryData") as? [SubCategoryData]
        message = aDecoder.decodeObject(forKey: "message") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Bool
        statusCode = aDecoder.decodeObject(forKey: "statusCode") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if mainCategoryData != nil{
            aCoder.encode(mainCategoryData, forKey: "mainCategoryData")
        }
        if subCategoryData != nil{
            aCoder.encode(subCategoryData, forKey: "subCategoryData")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if statusCode != nil{
            aCoder.encode(statusCode, forKey: "statusCode")
        }
        
    }
    
}
