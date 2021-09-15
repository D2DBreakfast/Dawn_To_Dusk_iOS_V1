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
                    HTTPHeader.init(name: "api_key", value: "JPcopEq16fyQGjnzY3QXVDnGDZrgQAs1"),
                    HTTPHeader.init(name: "accessToken", value: (SharedUserInfo.shared.GetUserToken())!)
                ]
            }
            else {
                return [
                    HTTPHeader.init(name: "Content-Type", value: "application/json"),
                    HTTPHeader.init(name: "api_key", value: "JPcopEq16fyQGjnzY3QXVDnGDZrgQAs1")
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
                            if obj.status! && obj.code == 200 {
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
                              onSuccess successCallback: ((_ response: GetOTPRootClass, _ status: Bool) -> Void)?,
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
                            let obj = GetOTPRootClass.init(fromJson: json)
                            if obj.status! && obj.code == 200 {
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
                               onSuccess successCallback: ((_ response: UserInfoRootClass, _ status: Bool) -> Void)?,
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
                            let obj = UserInfoRootClass.init(fromJson: json)
                            if obj.status! && obj.code == 200 {
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
    
    func GetCategoryListing(onSuccess successCallback: ((_ response: CategoryRootClass, _ status: Bool) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            guard let jsonData = readLocalFile(forName: "categorylist") else { return }
            guard let prettyPrintedJson = String(data: jsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
                return
            }
            let jsonObject = JSON(prettyPrintedJson.data(using: .utf8)!)
            let obj = CategoryRootClass.init(fromJson: jsonObject)
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
    
    func GetSubCategoryListing(param: SubCatParamDict,onSuccess successCallback: ((_ response: CategoryRootClass, _ status: Bool) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            guard let jsonData = readLocalFile(forName: "sub-categorylist") else { return }
            guard let prettyPrintedJson = String(data: jsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
                return
            }
            let jsonObject = JSON(prettyPrintedJson.data(using: .utf8)!)
            let obj = CategoryRootClass.init(fromJson: jsonObject)
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
    
    func GetFoodListing(param: ListingParamDict,
                        onSuccess successCallback: ((_ response: FoodRootClass, _ status: Bool) -> Void)?,
                        onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            guard let jsonData = readLocalFile(forName: "foodlisting") else { return }
            guard let prettyPrintedJson = String(data: jsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
                return
            }
            let jsonObject = JSON(prettyPrintedJson.data(using: .utf8)!)
            let obj = FoodRootClass.init(fromJson: jsonObject)
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
    
    func GetNotificationListing(onSuccess successCallback: ((_ response: NotificationRootClass2, _ status: Bool) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() || self.checkNetworkStatus()! {
            guard let jsonData = readLocalFile(forName: "notification") else { return }
            guard let prettyPrintedJson = String(data: jsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                failureCallback!("Error: Could print JSON in String")
                return
            }
            let jsonObject = JSON(prettyPrintedJson.data(using: .utf8)!)
            let obj = NotificationRootClass2.init(fromJson: jsonObject)
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
