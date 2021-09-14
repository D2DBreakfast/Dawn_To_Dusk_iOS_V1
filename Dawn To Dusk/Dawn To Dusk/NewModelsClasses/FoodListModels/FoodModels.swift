//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class FoodModels : NSObject, NSCoding {
    
    var cattegory : CategoryModels!
    var id : Int!
    var info : String!
    var isPackage : Bool!
    var isveg : Bool!
    var itemimage : String!
    var longdesc : String!
    var nutriInfo : String!
    var price : Double!
    var qty : Int!
    var shortdesc : String!
    var subCattegory : CategoryModels!
    var terms : String!
    var title : String!
    var works : String!
    var gallery : [String]!
    var items : [FoodModels]!
    var meals : [MealsModels]!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let cattegoryJson = json["cattegory"]
        if !cattegoryJson.isEmpty{
            cattegory = CategoryModels(fromJson: cattegoryJson)
        }
        id = json["id"].intValue
        info = json["info"].stringValue
        isPackage = json["isPackage"].boolValue
        isveg = json["isveg"].boolValue
        itemimage = json["itemimage"].stringValue
        longdesc = json["longdesc"].stringValue
        nutriInfo = json["nutri_info"].stringValue
        price = json["price"].doubleValue
        qty = json["qty"].intValue
        shortdesc = json["shortdesc"].stringValue
        let subCattegoryJson = json["sub_cattegory"]
        if !subCattegoryJson.isEmpty{
            subCattegory = CategoryModels(fromJson: subCattegoryJson)
        }
        terms = json["terms"].stringValue
        title = json["title"].stringValue
        works = json["works"].stringValue
        items = [FoodModels]()
        let itemsArray = json["items"].arrayValue
        for itemJson in itemsArray{
            let value = FoodModels(fromJson: itemJson)
            items.append(value)
        }
        gallery = json["gallery"].arrayValue.map { $0.stringValue }
        meals = [MealsModels]()
        let mealsArray = json["meals"].arrayValue
        for mealsJson in mealsArray{
            let value = MealsModels(fromJson: mealsJson)
            meals.append(value)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if cattegory != nil{
            dictionary["cattegory"] = cattegory.toDictionary()
        }
        if id != nil{
            dictionary["id"] = id
        }
        if info != nil{
            dictionary["info"] = info
        }
        if isPackage != nil{
            dictionary["isPackage"] = isPackage
        }
        if isveg != nil{
            dictionary["isveg"] = isveg
        }
        if itemimage != nil{
            dictionary["itemimage"] = itemimage
        }
        if longdesc != nil{
            dictionary["longdesc"] = longdesc
        }
        if nutriInfo != nil{
            dictionary["nutri_info"] = nutriInfo
        }
        if price != nil{
            dictionary["price"] = price
        }
        if qty != nil{
            dictionary["qty"] = qty
        }
        if shortdesc != nil{
            dictionary["shortdesc"] = shortdesc
        }
        if subCattegory != nil{
            dictionary["sub_cattegory"] = subCattegory.toDictionary()
        }
        if terms != nil{
            dictionary["terms"] = terms
        }
        if title != nil{
            dictionary["title"] = title
        }
        if works != nil{
            dictionary["works"] = works
        }
        if items != nil {
            var dictionaryElements = [[String:Any]]()
            for itemElement in items {
                dictionaryElements.append(itemElement.toDictionary())
            }
            dictionary["items"] = dictionaryElements
        }
        if gallery != nil {
            dictionary["gallery"] = gallery.map { $0 }
        }
        if meals != nil{
            var dictionaryElements = [[String:Any]]()
            for mealsElement in meals {
                dictionaryElements.append(mealsElement.toDictionary())
            }
            dictionary["meals"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        cattegory = aDecoder.decodeObject(forKey: "cattegory") as? CategoryModels
        id = aDecoder.decodeObject(forKey: "id") as? Int
        info = aDecoder.decodeObject(forKey: "info") as? String
        isPackage = aDecoder.decodeObject(forKey: "isPackage") as? Bool
        isveg = aDecoder.decodeObject(forKey: "isveg") as? Bool
        itemimage = aDecoder.decodeObject(forKey: "itemimage") as? String
        longdesc = aDecoder.decodeObject(forKey: "longdesc") as? String
        nutriInfo = aDecoder.decodeObject(forKey: "nutri_info") as? String
        price = aDecoder.decodeObject(forKey: "price") as? Double
        qty = aDecoder.decodeObject(forKey: "qty") as? Int
        shortdesc = aDecoder.decodeObject(forKey: "shortdesc") as? String
        subCattegory = aDecoder.decodeObject(forKey: "sub_cattegory") as? CategoryModels
        terms = aDecoder.decodeObject(forKey: "terms") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        works = aDecoder.decodeObject(forKey: "works") as? String
        items = aDecoder.decodeObject(forKey: "items") as? [FoodModels]
        gallery = aDecoder.decodeObject(forKey: "gallery") as? [String]
        meals = aDecoder.decodeObject(forKey: "meals") as? [MealsModels]
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if cattegory != nil{
            aCoder.encode(cattegory, forKey: "cattegory")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if info != nil{
            aCoder.encode(info, forKey: "info")
        }
        if isPackage != nil{
            aCoder.encode(isPackage, forKey: "isPackage")
        }
        if isveg != nil{
            aCoder.encode(isveg, forKey: "isveg")
        }
        if itemimage != nil{
            aCoder.encode(itemimage, forKey: "itemimage")
        }
        if longdesc != nil{
            aCoder.encode(longdesc, forKey: "longdesc")
        }
        if nutriInfo != nil{
            aCoder.encode(nutriInfo, forKey: "nutri_info")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if qty != nil{
            aCoder.encode(qty, forKey: "qty")
        }
        if shortdesc != nil{
            aCoder.encode(shortdesc, forKey: "shortdesc")
        }
        if subCattegory != nil{
            aCoder.encode(subCattegory, forKey: "sub_cattegory")
        }
        if terms != nil{
            aCoder.encode(terms, forKey: "terms")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if works != nil{
            aCoder.encode(works, forKey: "works")
        }
        if items != nil{
            aCoder.encode(items, forKey: "items")
        }
        if gallery != nil{
            aCoder.encode(gallery, forKey: "gallery")
        }
        if meals != nil{
            aCoder.encode(meals, forKey: "meals")
        }
        
    }
    
}
