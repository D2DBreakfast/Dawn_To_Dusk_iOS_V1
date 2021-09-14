//
//    Banner.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class BannerModels : NSObject, NSCoding{

    var bannerDes : String!
    var bannerImage : String!
    var bannerName : String!
    var bannerTitle : String!
    var id : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        bannerDes = json["banner_des"].stringValue
        bannerImage = json["banner_image"].stringValue
        bannerName = json["banner_name"].stringValue
        bannerTitle = json["banner_title"].stringValue
        id = json["id"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if bannerDes != nil{
            dictionary["banner_des"] = bannerDes
        }
        if bannerImage != nil{
            dictionary["banner_image"] = bannerImage
        }
        if bannerName != nil{
            dictionary["banner_name"] = bannerName
        }
        if bannerTitle != nil{
            dictionary["banner_title"] = bannerTitle
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
         bannerDes = aDecoder.decodeObject(forKey: "banner_des") as? String
         bannerImage = aDecoder.decodeObject(forKey: "banner_image") as? String
         bannerName = aDecoder.decodeObject(forKey: "banner_name") as? String
         bannerTitle = aDecoder.decodeObject(forKey: "banner_title") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if bannerDes != nil{
            aCoder.encode(bannerDes, forKey: "banner_des")
        }
        if bannerImage != nil{
            aCoder.encode(bannerImage, forKey: "banner_image")
        }
        if bannerName != nil{
            aCoder.encode(bannerName, forKey: "banner_name")
        }
        if bannerTitle != nil{
            aCoder.encode(bannerTitle, forKey: "banner_title")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }

    }

}
