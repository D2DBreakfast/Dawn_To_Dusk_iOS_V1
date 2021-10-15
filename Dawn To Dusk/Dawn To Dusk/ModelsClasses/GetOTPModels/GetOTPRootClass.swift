//
//	GetOTPRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class GetOTPRootClass : NSObject, NSCoding {
    
    var message : String!
    var otpData : GetOTPData!
    var status : Bool!
    var statusCode : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        message = json["message"].stringValue
        let otpDataJson = json["otpData"]
        if !otpDataJson.isEmpty{
            otpData = GetOTPData(fromJson: otpDataJson)
        }
        status = json["status"].boolValue
        statusCode = json["statusCode"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if message != nil{
            dictionary["message"] = message
        }
        if otpData != nil{
            dictionary["otpData"] = otpData.toDictionary()
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
         message = aDecoder.decodeObject(forKey: "message") as? String
         otpData = aDecoder.decodeObject(forKey: "otpData") as? GetOTPData
         status = aDecoder.decodeObject(forKey: "status") as? Bool
         statusCode = aDecoder.decodeObject(forKey: "statusCode") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if otpData != nil{
            aCoder.encode(otpData, forKey: "otpData")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if statusCode != nil{
            aCoder.encode(statusCode, forKey: "statusCode")
        }

    }

}
