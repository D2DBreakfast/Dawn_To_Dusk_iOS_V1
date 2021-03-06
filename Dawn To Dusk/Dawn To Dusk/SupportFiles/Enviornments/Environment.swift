//
//  Environment.swift
//  Pulse
//
//  Created by Shorupan Pirakaspathy on 2020-03-27.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit
import Foundation

public enum PlistKey {
    case TimeoutInterval
    case ConnectionProtocol
    case ServerURL
    case DomainFolder
    case RegisterAPI
    case LoginAPI
    case VerifyOtpAPI
    case UpdateUserAPI
    case GetMenuListing
    case GetSubCatMenuListing
    case GlobalSearchURL
    case GetMainCategory
    case GetSubCategory
    case PlaceOrderAPI
    case AddToCartAPI
    case MyCartListAPI
    case GetOrderHistory
    
    func value() -> String {
        switch self {
        case .TimeoutInterval:
            return "timeout_interval"
        case .ConnectionProtocol:
            return "protocol"
        case .ServerURL:
            return "server_url"
        case .DomainFolder:
            return "DomainFolder"
        case .RegisterAPI:
            return "RegisterAPI"
        case .LoginAPI:
            return "LoginAPI"
        case .VerifyOtpAPI:
            return "VerifyOtpAPI"
        case .UpdateUserAPI:
            return "UpdateUserAPI"
        case .GetMenuListing:
            return "GetMenuListing"
        case .GetSubCatMenuListing:
            return "GetSubCatMenuListing"
        case .GlobalSearchURL:
            return "GlobalSearchURL"
        case .GetMainCategory:
            return "GetMainCategory"
        case .GetSubCategory:
            return "GetSubCategory"
        case .PlaceOrderAPI:
            return "PlaceOrderAPI"
        case .AddToCartAPI:
            return "AddToCartAPI"
        case .MyCartListAPI:
            return "MyCartListAPI"
        case .GetOrderHistory:
            return "GetOrderHistory"
        }
    }
}

public struct Environments {
    
    static let shared = Environments()
    
    var infoDict: [String : Any]!
    
    private init() {
        if let dict = Bundle.main.infoDictionary {
            self.infoDict = dict
        }else {
            fatalError("Plist file not found")
        }
    }
    
    public func configuration(_ key: PlistKey) -> String {
        let keyExists = infoDict[key.value()] != nil
        if keyExists {
            print("The key is present in the Infodictionary")
            switch key {
            case .TimeoutInterval:
                return infoDict[PlistKey.TimeoutInterval.value()] as! String
            case .ConnectionProtocol:
                return infoDict[PlistKey.ConnectionProtocol.value()] as! String
            case .ServerURL:
                return infoDict[PlistKey.ServerURL.value()] as! String
            case .DomainFolder:
                return infoDict[PlistKey.DomainFolder.value()] as! String
            case .RegisterAPI:
                return infoDict[PlistKey.RegisterAPI.value()] as! String
            case .LoginAPI:
                return infoDict[PlistKey.LoginAPI.value()] as! String
            case .VerifyOtpAPI:
                return infoDict[PlistKey.VerifyOtpAPI.value()] as! String
            case .UpdateUserAPI:
                return infoDict[PlistKey.UpdateUserAPI.value()] as! String
            case .GetMenuListing:
                return infoDict[PlistKey.GetMenuListing.value()] as! String
            case .GetSubCatMenuListing:
                return infoDict[PlistKey.GetSubCatMenuListing.value()] as! String
            case .GlobalSearchURL:
                return infoDict[PlistKey.GlobalSearchURL.value()] as! String
            case .GetMainCategory:
                return infoDict[PlistKey.GetMainCategory.value()] as! String
            case .GetSubCategory:
                return infoDict[PlistKey.GetSubCategory.value()] as! String
            case .PlaceOrderAPI:
                return infoDict[PlistKey.PlaceOrderAPI.value()] as! String
            case .AddToCartAPI:
                return infoDict[PlistKey.AddToCartAPI.value()] as! String
            case .MyCartListAPI:
                return infoDict[PlistKey.MyCartListAPI.value()] as! String
            case .GetOrderHistory:
                return infoDict[PlistKey.GetOrderHistory.value()] as! String
            }
        } else {
            print("The key is not present in the Infodictionary")
            return ""
        }
    }
    
    public func GetDomainURL(_ key: PlistKey) -> String {
        let protocols = Environments.shared.configuration(PlistKey.ConnectionProtocol)
        let serverurl = Environments.shared.configuration(PlistKey.ServerURL)
        let domainfolder = Environments.shared.configuration(PlistKey.DomainFolder)
        let callKey = Environments.shared.configuration(key)
        if protocols.count != 0 || serverurl.count != 0 || callKey.count != 0 {
            let APIURL = String.init(format: "%@://%@%@%@", protocols, serverurl, domainfolder, callKey)
            return callKey.count >= 1 ? APIURL : ""
        }
        else {
            return ""
        }
    }
    
    public func getPlistFilename() -> String {
        #if Dev_DEBUG || Dev_RELEASE
        return "Dev"
        #elseif UAT_DEBUG || UAT_RELEASE
        return "UAT"
        #elseif QAT_DEBUG || QAT_RELEASE
        return "QAT"
        #else
        return "Prod"
        #endif
    }
    
    public func getPath() -> String {
        let plistFileName: String!
        plistFileName = self.getPlistFilename()
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentPath = paths[0] as NSString
        let plistPath = documentPath.appendingPathComponent(plistFileName)
        return plistPath
    }
    
    public func RetrivePlistdata()-> NSDictionary? {
        if FileManager.default.fileExists(atPath: self.getPath()) {
            let dict = NSMutableDictionary.init(contentsOfFile: self.getPath())
            return dict
        }
        return nil
    }
    
    public func RemovePlistdata(key: String) {
        if FileManager.default.fileExists(atPath: self.getPath()) {
            let dict: NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: self.getPath())!
            dict.removeObject(forKey: key)
            dict.write(toFile: self.getPath(), atomically: true)
        }
    }
    
    public func updatePlistdata(key: String, value: Any) {
        if FileManager.default.fileExists(atPath: self.getPath()) {
            let dict: NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: self.getPath())!
            let data = dict.object(forKey: key) as AnyObject
            if data.isMember(of: NSArray.self) {
                dict.setValue(value, forKey: key)
            }
            else if data.isMember(of: NSDictionary.self) {
                dict.setValue(value, forKey: key)
            }
            else {
                dict.setValue(data, forKey: key)
            }
            dict.write(toFile: self.getPath(), atomically: true)
        }
    }
    
}
