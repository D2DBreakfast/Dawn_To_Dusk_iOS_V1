//
//  NetworkingRequests.swift
//  Lead
//
//  Created by Hiren Joshi on 03/01/20.
//  Copyright © 2020 Hiren Joshi. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import RxAlamofire
import RxCocoa
import RxSwift
import SwiftyJSON


struct SetupHTTP_Header {
    
    var header: HTTPHeaders? {
        get {
            if SharedUserInfo.shared.IsUserLoggedin()! {
                return [
                    HTTPHeader.init(name: "Content-Type", value: "application/json"),
                    HTTPHeader.init(name: "token", value: (SharedUserInfo.shared.GetUserToken())!)
                ]
            }
            else {
                return [
                    HTTPHeader.init(name: "Content-Type", value: "application/json"),
                ]
            }
        }
    }
    
}


enum APIError: Error {
    case InternetConnection
    case invalidInput
    case badResposne
    case invalidURL
    
    func toNSError() -> NSError {
        let domain = "Domain url"
        switch self {
        case .InternetConnection:
            return NSError(domain: domain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Internet connection not available please, check Internet and try agian!"])
        case .invalidURL:
            return NSError(domain: domain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Input should be a valid URL"])
        case .invalidInput:
            return NSError(domain: domain, code: -2, userInfo: [NSLocalizedDescriptionKey: "Input should be a valid number"])
        case .badResposne:
            return NSError(domain: domain, code: -3, userInfo: [NSLocalizedDescriptionKey: "Bad response"])
        }
    }
}

@objc public class NetworkingRequests: NSObject {
    
    static let shared = NetworkingRequests()
    
    var successcomplitionHandler: ((_ data: Any)->Void)?
    var onError: ((_ msg: String, _ ErrCode: NSInteger?)->Void)?
    var rechability: Reachability!
    
    @objc class var swiftSharedInstance: NetworkingRequests {
        struct Singleton {
            static let instance = NetworkingRequests()
        }
        return Singleton.instance
    }
    
    // the sharedInstance class method can be reached from ObjC
    @objc class func sharedInstance() -> NetworkingRequests {
        return NetworkingRequests.swiftSharedInstance
    }
    
    private override init() {
        self.rechability = Reachability.init(hostname: "www.google.com")
        self.rechability.startNotifier()
    }
    
    static func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    class func getCurrentViewController() -> UIViewController? {
        if #available(iOS 13, *) {
            let window = UIApplication.shared.windows
            if let rootController = window[0].rootViewController {
                var currentController: UIViewController! = rootController
                while( currentController.presentedViewController != nil ) {
                    currentController = currentController.presentedViewController
                }
                return currentController
            }
            return nil
        } else {
            
            if let rootController = UIApplication.shared.keyWindow?.rootViewController {
                var currentController: UIViewController! = rootController
                while( currentController.presentedViewController != nil ) {
                    currentController = currentController.presentedViewController
                }
                return currentController
            }
            return nil
        }
    }
    
    class func displayError(_ error: NSError?) {
        if let e = error {
            let alertController = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // do nothing...
            }
            alertController.addAction(okAction)
            self.getCurrentViewController()!.present(alertController, animated: true, completion: nil)
        }
    }
    
    func checkNetworkStatus() -> Bool? {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            return false
            
        case .online(.wwan):
            print("Connected via WWAN")
            return true
            
        case .online(.wiFi):
            print("Connected via WiFi")
            return true
        }
    }
    
}

//MARK:- JsonCOnverter
extension NetworkingRequests {
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

//MARK:- Request Methods
extension NetworkingRequests {
    
    func Request_SendOTP(param: SendotpParamDict,
                         onSuccess successCallback: ((_ response: GetOTPRootClass, _ status: Bool) -> Void)?,
                         onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            let url = String.init(format: "%@", Environments.shared.GetDomainURL(.LoginAPI))
            if url.count != 0 {
                RxAlamofire.requestJSON(.post, url, parameters: param.description, encoding: JSONEncoding.default, headers: SetupHTTP_Header().header).observe(on: MainScheduler.asyncInstance)
                    .subscribe(onNext: { (arg0) in
                        let (responseobject, results) = arg0
                        guard results is [String: Any] else {
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: results, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            failureCallback!("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            failureCallback!("Error: Could print JSON in String")
                            return
                        }
                        if responseobject.statusCode == 200 {
                            print(responseobject)
                            print(results)
                            let jsonData = prettyPrintedJson.data(using: .utf8)!
                            let json = JSON(jsonData)
                            let obj = GetOTPRootClass.init(fromJson: json)
                            if obj.status! && obj.statusCode == 200 {
                                successCallback?(obj, true)
                            }
                            else {
                                failureCallback?(obj.message!)
                            }
                        }
                        else {
                            let jsonData = prettyPrintedJson.data(using: .utf8)!
                            let json = JSON(jsonData)
                            let obj = BasicServicesRootClass.init(fromJson: json)
                            AppUtillity.shared.NetworkIndicator(status: false)
                            failureCallback!(obj.message)
                        }
                    }, onError: { (error) in
                        AppUtillity.shared.NetworkIndicator(status: false)
                        failureCallback!(error.localizedDescription)
                    }, onCompleted: {
                        
                    }) {
                        
                    }
                
            }
            else {
                failureCallback!(APIError.invalidURL.toNSError().localizedDescription)
            }
        }
        else {
            failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
        }
        
    }
    
    func Request_RegisterUser(param: RegisterParamDict,
                              onSuccess successCallback: ((_ response: UserInfoRootClass, _ status: Bool) -> Void)?,
                              onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            let url = String.init(format: "%@", Environments.shared.GetDomainURL(.RegisterAPI))
            if url.count != 0 {
                RxAlamofire.requestJSON(.post, url, parameters: param.description, encoding: JSONEncoding.default, headers: SetupHTTP_Header().header).observe(on: MainScheduler.asyncInstance)
                    .subscribe(onNext: { (arg0) in
                        let (responseobject, results) = arg0
                        guard results is [String: Any] else {
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: results, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            failureCallback!("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            failureCallback!("Error: Could print JSON in String")
                            return
                        }
                        if responseobject.statusCode == 200 {
                            print(responseobject)
                            print(results)
                            let jsonData = prettyPrintedJson.data(using: .utf8)!
                            let json = JSON(jsonData)
                            let obj = UserInfoRootClass.init(fromJson: json)
                            if obj.status! && obj.statusCode == 200 {
                                successCallback?(obj, true)
                            }
                            else {
                                failureCallback?(obj.message!)
                            }
                        }
                        else {
                            let jsonData = prettyPrintedJson.data(using: .utf8)!
                            let json = JSON(jsonData)
                            let obj = BasicServicesRootClass.init(fromJson: json)
                            AppUtillity.shared.NetworkIndicator(status: false)
                            failureCallback!(obj.message)
                        }
                    }, onError: { (error) in
                        AppUtillity.shared.NetworkIndicator(status: false)
                        failureCallback!(error.localizedDescription)
                    }, onCompleted: {
                        
                    }) {
                        
                    }
            }
            else {
                failureCallback!(APIError.invalidURL.toNSError().localizedDescription)
            }
        }
        else {
            failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
        }
        
    }
    
    func Request_UserVerifyOTP(param: OTPcodeParamDict,
                               onSuccess successCallback: ((_ response: GetOTPRootClass, _ status: Bool) -> Void)?,
                               onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            let url = String.init(format: "%@", Environments.shared.GetDomainURL(.VerifyOtpAPI))
            if url.count != 0 {
                RxAlamofire.requestJSON(.post, url, parameters: param.description, encoding: JSONEncoding.default, headers: SetupHTTP_Header().header).observe(on: MainScheduler.asyncInstance)
                    .subscribe(onNext: { (arg0) in
                        let (responseobject, results) = arg0
                        guard results is [String: Any] else {
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: results, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            failureCallback!("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            failureCallback!("Error: Could print JSON in String")
                            return
                        }
                        if responseobject.statusCode == 200 {
                            print(responseobject)
                            print(results)
                            let jsonData = prettyPrintedJson.data(using: .utf8)!
                            let json = JSON(jsonData)
                            let obj = GetOTPRootClass.init(fromJson: json)
                            if obj.status! && obj.statusCode == 200 {
                                successCallback?(obj, true)
                            }
                            else {
                                failureCallback?(obj.message!)
                            }
                        }
                        else {
                            let jsonData = prettyPrintedJson.data(using: .utf8)!
                            let json = JSON(jsonData)
                            let obj = BasicServicesRootClass.init(fromJson: json)
                            AppUtillity.shared.NetworkIndicator(status: false)
                            failureCallback!(obj.message)
                        }
                    }, onError: { (error) in
                        AppUtillity.shared.NetworkIndicator(status: false)
                        failureCallback!(error.localizedDescription)
                    }, onCompleted: {
                        
                    }) {
                        
                    }
            }
            else {
                failureCallback!(APIError.invalidURL.toNSError().localizedDescription)
            }
        }
        else {
            failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
        }
        
    }
    
    func Request_UpdateProfile(param: UpdateProfileParamDict,
                         onSuccess successCallback: ((_ response: UserInfoRootClass, _ status: Bool) -> Void)?,
                         onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            let url = String.init(format: "%@", Environments.shared.GetDomainURL(.UpdateUserAPI))
            if url.count != 0 {
                RxAlamofire.requestJSON(.post, url, parameters: param.description, encoding: JSONEncoding.default, headers: SetupHTTP_Header().header).observe(on: MainScheduler.asyncInstance)
                    .subscribe(onNext: { (arg0) in
                        let (responseobject, results) = arg0
                        guard results is [String: Any] else {
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: results, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            failureCallback!("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            failureCallback!("Error: Could print JSON in String")
                            return
                        }
                        if responseobject.statusCode == 200 {
                            print(responseobject)
                            print(results)
                            let jsonData = prettyPrintedJson.data(using: .utf8)!
                            let json = JSON(jsonData)
                            let obj = UserInfoRootClass.init(fromJson: json)
                            if obj.status! && obj.statusCode == 200 {
                                successCallback?(obj, true)
                            }
                            else {
                                failureCallback?(obj.message!)
                            }
                        }
                        else {
                            let jsonData = prettyPrintedJson.data(using: .utf8)!
                            let json = JSON(jsonData)
                            let obj = BasicServicesRootClass.init(fromJson: json)
                            AppUtillity.shared.NetworkIndicator(status: false)
                            failureCallback!(obj.message)
                        }
                    }, onError: { (error) in
                        AppUtillity.shared.NetworkIndicator(status: false)
                        failureCallback!(error.localizedDescription)
                    }, onCompleted: {
                        
                    }) {
                        
                    }
            }
            else {
                failureCallback!(APIError.invalidURL.toNSError().localizedDescription)
            }
        }
        else {
            failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
        }
        
    }
    
    func post_RequestAPI_calling(URL_Str: String, param: [String: Any],
                         onSuccess Callback_Success: ((_ response: JSON, _ status: Bool) -> Void)?,
                         onFailure Callback_Failure: ((_ errorMessage: String) -> Void)?) {
        
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            if URL_Str.count != 0 {
                RxAlamofire.requestJSON(.post, URL_Str, parameters: param, encoding: JSONEncoding.default, headers: SetupHTTP_Header().header).observe(on: MainScheduler.asyncInstance)
                    .subscribe(onNext: { (arg0) in
                        let (responseobject, results) = arg0
                        guard results is [String: Any] else {
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: results, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            Callback_Failure!("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            Callback_Failure!("Error: Could print JSON in String")
                            return
                        }
                        if responseobject.statusCode == 200 {
                            print(responseobject)
                            print(results)
                            let jsonData = prettyPrintedJson.data(using: .utf8)!
                            let json = JSON(jsonData)
                            Callback_Success?(json, true)
                        }
                        else {
                            let jsonData = prettyPrintedJson.data(using: .utf8)!
                            let json = JSON(jsonData)
                            let obj = BasicServicesRootClass.init(fromJson: json)
                            AppUtillity.shared.NetworkIndicator(status: false)
                            Callback_Failure!(obj.message)
                        }
                    }, onError: { (error) in
                        AppUtillity.shared.NetworkIndicator(status: false)
                        Callback_Failure!(error.localizedDescription)
                    }, onCompleted: {
                        
                    }) {
                        
                    }
            }
            else {
                Callback_Failure!(APIError.invalidURL.toNSError().localizedDescription)
            }
        }
        else {
            Callback_Failure!(APIError.InternetConnection.toNSError().localizedDescription)
        }
        
    }
    
    func GetCategoryListing(onSuccess successCallback: ((_ response: MenuCategoryRootClass, _ status: Bool) -> Void)?,
                            onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            let url = String.init(format: "%@", Environments.shared.GetDomainURL(.GetMainCategory))
            self.post_RequestAPI_calling(URL_Str: url, param: [:]) { response, status in
                let obj = MenuCategoryRootClass.init(fromJson: response)
                if obj.status! && obj.statusCode == 200 {
                    successCallback?(obj, true)
                }
                else {
                    failureCallback?(obj.message!)
                }
            } onFailure: { errorMessage in
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
            }
        }
        else {
            failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
        }
    }
    
    func GetSubCategoryListing(param: SubCatParamDict, onSuccess successCallback: ((_ response: MenuCategoryRootClass, _ status: Bool) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            let url = String.init(format: "%@", Environments.shared.GetDomainURL(.GetSubCategory))
            self.post_RequestAPI_calling(URL_Str: url, param: param.description) { response, status in
                let obj = MenuCategoryRootClass.init(fromJson: response)
                if obj.status! && obj.statusCode == 200 {
                    successCallback?(obj, true)
                }
                else {
                    failureCallback?(obj.message!)
                }
            } onFailure: { errorMessage in
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
            }
        }
        else {
            failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
        }
    }
    
    func GetFoodListing(param: ListingParamDict,
                        onSuccess successCallback: ((_ response: MenuItemsRootClass, _ status: Bool) -> Void)?,
                        onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            let url = String.init(format: "%@", Environments.shared.GetDomainURL(.GetMenuListing))
            self.post_RequestAPI_calling(URL_Str: url, param: param.description) { response, status in
                let obj = MenuItemsRootClass.init(fromJson: response)
                if obj.status! && obj.statusCode == 200 {
                    successCallback?(obj, true)
                }
                else {
                    failureCallback?(obj.message!)
                }
            } onFailure: { errorMessage in
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
            }
        }
        else {
            failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
        }
    }
    
    func GetSubcatFoodListing(param: ListingParamDict,
                        onSuccess successCallback: ((_ response: MenuItemsRootClass, _ status: Bool) -> Void)?,
                        onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            let url = String.init(format: "%@", Environments.shared.GetDomainURL(.GetSubCatMenuListing))
            self.post_RequestAPI_calling(URL_Str: url, param: param.description) { response, status in
                let obj = MenuItemsRootClass.init(fromJson: response)
                if obj.status! && obj.statusCode == 200 {
                    successCallback?(obj, true)
                }
                else {
                    failureCallback?(obj.message!)
                }
            } onFailure: { errorMessage in
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
            }
        }
        else {
            failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
        }
    }
    
    func Call_AddtoCartAPI(param: Place_ToCart_OrderParamDict,
                        onSuccess successCallback: ((_ response: BasicServicesRootClass, _ status: Bool) -> Void)?,
                        onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            let url = String.init(format: "%@", Environments.shared.GetDomainURL(.AddToCartAPI))
            self.post_RequestAPI_calling(URL_Str: url, param: param.description) { response, status in
                let obj = BasicServicesRootClass.init(fromJson: response)
                if obj.status! && obj.statusCode == 200 {
                    successCallback?(obj, true)
                }
                else {
                    failureCallback?(obj.message!)
                }
            } onFailure: { errorMessage in
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
            }
        }
        else {
            failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
        }
    }
    
    func GetCartListingAPI(param: MyCartParamDict,
                        onSuccess successCallback: ((_ response: MyCartRootClass, _ status: Bool) -> Void)?,
                        onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            let url = String.init(format: "%@", Environments.shared.GetDomainURL(.MyCartListAPI))
            self.post_RequestAPI_calling(URL_Str: url, param: param.description) { response, status in
                let obj = MyCartRootClass.init(fromJson: response)
                if obj.status! && obj.statusCode == 200 {
                    successCallback?(obj, true)
                }
                else {
                    failureCallback?(obj.message!)
                }
            } onFailure: { errorMessage in
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
            }
        }
        else {
            failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
        }
    }
    
    func GetOrderHistoryAPI(param: MyCartParamDict,
                        onSuccess successCallback: ((_ response: OrderDetailsRootClass, _ status: Bool) -> Void)?,
                        onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            let url = String.init(format: "%@", Environments.shared.GetDomainURL(.GetOrderHistory))
            self.post_RequestAPI_calling(URL_Str: url, param: param.description) { response, status in
                let obj = OrderDetailsRootClass.init(fromJson: response)
                if obj.status! && obj.statusCode == 200 {
                    successCallback?(obj, true)
                }
                else {
                    failureCallback?(obj.message!)
                }
            } onFailure: { errorMessage in
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
            }
        }
        else {
            failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
        }
    }
    
    func PlaceOrderFromUser(param: Place_ToCart_OrderParamDict,
                            onSuccess successCallback: ((_ response: BasicServicesRootClass, _ status: Bool) -> Void)?,
                            onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        let now = Date()
        let order_dead_line = now.dateAt(hours: 10, minutes: 0)
        if now >= order_dead_line {
            if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
                let url = String.init(format: "%@", Environments.shared.GetDomainURL(.PlaceOrderAPI))
                self.post_RequestAPI_calling(URL_Str: url, param: param.description) { response, status in
                    let obj = BasicServicesRootClass.init(fromJson: response)
                    if obj.status! && obj.statusCode == 200 {
                        successCallback?(obj, true)
                    }
                    else {
                        failureCallback?(obj.message!)
                    }
                } onFailure: { errorMessage in
                    print("Error: Could print JSON in String")
                    failureCallback!("Error: Could print JSON in String")
                }
            }
            else {
                failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
            }
        }
        else {
            failureCallback!("You can place the order before 10. Now the restaurent is closed. Please try by tomorrow!")
        }
    }
    
    func GlobalSearchlist(param: GlobalSearcgDict,
                        onSuccess successCallback: ((_ response: MenuItemsRootClass, _ status: Bool) -> Void)?,
                        onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            let url = String.init(format: "%@", Environments.shared.GetDomainURL(.GlobalSearchURL))
            self.post_RequestAPI_calling(URL_Str: url, param: param.description) { response, status in
                let obj = MenuItemsRootClass.init(fromJson: response)
                if obj.status! && obj.statusCode == 200 {
                    successCallback?(obj, true)
                }
                else {
                    failureCallback?(obj.message!)
                }
            } onFailure: { errorMessage in
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
            }
        }
        else {
            failureCallback!(APIError.InternetConnection.toNSError().localizedDescription)
        }
    }
    
    func GetAddressListing(onSuccess successCallback: ((_ response: UserInfoAddresRootClass, _ status: Bool) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            guard let jsonData = readLocalFile(forName: "address") else { return }
            guard let prettyPrintedJson = String(data: jsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
                return
            }
            let jsonObject = JSON(prettyPrintedJson.data(using: .utf8)!)
            let obj = UserInfoAddresRootClass.init(fromJson: jsonObject)
            if obj.status! && obj.code == 200 {
                successCallback?(obj, true)
            }
            else {
                failureCallback?(obj.message!)
            }
        }
        else {
            
        }
    }
    
    func GetNotificationListing(onSuccess successCallback: ((_ response: NotificationRootClass, _ status: Bool) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            guard let jsonData = readLocalFile(forName: "notification") else { return }
            guard let prettyPrintedJson = String(data: jsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
                return
            }
            let jsonObject = JSON(prettyPrintedJson.data(using: .utf8)!)
            let obj = NotificationRootClass.init(fromJson: jsonObject)
            if obj.status! && obj.code == 200 {
                successCallback?(obj, true)
            }
            else {
                failureCallback?(obj.message!)
            }
        }
        else {
            
        }
    }
    
    func GetbannerListing(onSuccess successCallback: ((_ response: BannerRootClass, _ status: Bool) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            guard let jsonData = readLocalFile(forName: "banner") else { return }
            guard let prettyPrintedJson = String(data: jsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
                return
            }
            let jsonObject = JSON(prettyPrintedJson.data(using: .utf8)!)
            let obj = BannerRootClass.init(fromJson: jsonObject)
            if obj.status! && obj.code == 200 {
                successCallback?(obj, true)
            }
            else {
                failureCallback?(obj.message!)
            }
        }
        else {
            
        }
    }
    
    func GetPaymentmodeListing(onSuccess successCallback: ((_ response: PaymentModeRootClass, _ status: Bool) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            guard let jsonData = readLocalFile(forName: "paymentmode") else { return }
            guard let prettyPrintedJson = String(data: jsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
                return
            }
            let jsonObject = JSON(prettyPrintedJson.data(using: .utf8)!)
            let obj = PaymentModeRootClass.init(fromJson: jsonObject)
            if obj.status! && obj.code == 200 {
                successCallback?(obj, true)
            }
            else {
                failureCallback?(obj.message!)
            }
        }
        else {
            
        }
    }
    
    func GetCartListing(onSuccess successCallback: ((_ response: OrderHistoryRootClass, _ status: Bool) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            guard let jsonData = readLocalFile(forName: "cartlist") else { return }
            guard let prettyPrintedJson = String(data: jsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
                return
            }
            let jsonObject = JSON(prettyPrintedJson.data(using: .utf8)!)
            let obj = OrderHistoryRootClass.init(fromJson: jsonObject)
            if obj.status! && obj.code == 200 {
                successCallback?(obj, true)
            }
            else {
                failureCallback?(obj.message!)
            }
        }
        else {
            
        }
    }
    
    func GetCartHistoryListing(onSuccess successCallback: ((_ response: OrderHistoryRootClass, _ status: Bool) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            guard let jsonData = readLocalFile(forName: "OrderHistory") else { return }
            guard let prettyPrintedJson = String(data: jsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
                return
            }
            let jsonObject = JSON(prettyPrintedJson.data(using: .utf8)!)
            let obj = OrderHistoryRootClass.init(fromJson: jsonObject)
            if obj.status! && obj.code == 200 {
                successCallback?(obj, true)
            }
            else {
                failureCallback?(obj.message!)
            }
        }
        else {
            
        }
    }
    
    func GetCouponsListing(onSuccess successCallback: ((_ response: CouponModelsRootClass, _ status: Bool) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            guard let jsonData = readLocalFile(forName: "couponlist") else { return }
            guard let prettyPrintedJson = String(data: jsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
                return
            }
            let jsonObject = JSON(prettyPrintedJson.data(using: .utf8)!)
            let obj = CouponModelsRootClass.init(fromJson: jsonObject)
            if obj.status! && obj.code == 200 {
                successCallback?(obj, true)
            }
            else {
                failureCallback?(obj.message!)
            }
        }
        else {
            
        }
    }
    
    
}
