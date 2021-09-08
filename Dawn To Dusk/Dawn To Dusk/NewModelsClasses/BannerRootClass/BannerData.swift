//
//    BannerData.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class BannerData : NSObject, NSCoding{

    var banner : [BannerModels]!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        banner = [BannerModels]()
        let bannerArray = json["banner"].arrayValue
        for bannerJson in bannerArray{
            let value = BannerModels(fromJson: bannerJson)
            banner.append(value)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if banner != nil{
            var dictionaryElements = [[String:Any]]()
            for bannerElement in banner {
                dictionaryElements.append(bannerElement.toDictionary())
            }
            dictionary["banner"] = dictionaryElements
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         banner = aDecoder.decodeObject(forKey: "banner") as? [BannerModels]

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if banner != nil{
            aCoder.encode(banner, forKey: "banner")
        }

    }

}
