//
//    MenuItemsRootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class MenuItemsRootClass : NSObject, NSCoding{

    var menuData : MenuItemsMenuData!
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
        let menuDataJson = json["menuData"]
        if !menuDataJson.isEmpty{
            menuData = MenuItemsMenuData(fromJson: menuDataJson)
        }
        let menuSearchDataJson = json["menuSearchData"]
        if !menuSearchDataJson.isEmpty{
            menuData = MenuItemsMenuData(fromJson: menuSearchDataJson)
        }
        let subCategoryMenuDataJson = json["subCategoryMenuData"]
        if !subCategoryMenuDataJson.isEmpty{
            menuData = MenuItemsMenuData(fromJson: subCategoryMenuDataJson)
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
        if menuData != nil{
            dictionary["menuData"] = menuData.toDictionary()
        }
        if menuData != nil{
            dictionary["menuSearchData"] = menuData.toDictionary()
        }
        if menuData != nil{
            dictionary["subCategoryMenuData"] = menuData.toDictionary()
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
        menuData = aDecoder.decodeObject(forKey: "menuData") as? MenuItemsMenuData
        menuData = aDecoder.decodeObject(forKey: "menuSearchData") as? MenuItemsMenuData
        menuData = aDecoder.decodeObject(forKey: "subCategoryMenuData") as? MenuItemsMenuData
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
        if menuData != nil{
            aCoder.encode(menuData, forKey: "menuData")
        }
        if menuData != nil{
            aCoder.encode(menuData, forKey: "menuSearchData")
        }
        if menuData != nil{
            aCoder.encode(menuData, forKey: "subCategoryMenuData")
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
