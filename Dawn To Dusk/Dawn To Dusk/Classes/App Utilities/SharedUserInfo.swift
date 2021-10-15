//
//  SharedUserInfo.swift
//  Pulse
//
//  Created by Hiren on 22/07/21.
//

import UIKit

@objc public class SharedUserInfo: NSObject {

    var isFirstLaunch: Bool {
        get {
            !UserDefaults.standard.bool(forKey: #function)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }
    
    static let shared = SharedUserInfo()
    public var mydefault : UserDefaults!
    
    @objc class var swiftSharedInstance: SharedUserInfo {
        struct Singleton {
            static let instance = SharedUserInfo()
        }
        return Singleton.instance
    }
    
    // the sharedInstance class method can be reached from ObjC
    @objc class func sharedInstance() -> SharedUserInfo {
        return SharedUserInfo.swiftSharedInstance
    }
    
    private override init() {
        self.mydefault = UserDefaults.standard
        self.mydefault.synchronize()
    }
    
    func IsUserLoggedin() -> Bool? {
        let info = GetUserInfodata()
        let islogin = self.mydefault.bool(forKey: isUserLogedIn)
        if islogin {
            if info == nil || info?.token == nil || info?.token?.count == 0 {
                return false
            }
            else {
                return true
            }
        }
        else {
            return false
        }
    }
    
    func SetLoginBool() {
        self.mydefault.set(true, forKey: isUserLogedIn)
    }
    
    func SaveUserInfodata(info: UserInfoUser) {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(info) {
//            self.mydefault.set(encoded, forKey: LoginUserData)
//        }
        do {
            let personData = try! NSKeyedArchiver.archivedData(withRootObject: info, requiringSecureCoding: false)
//            let personData = NSKeyedArchiver.archivedData(withRootObject: info)
            self.mydefault.set(personData, forKey: LoginUserData)
            self.SetLoginBool()
        }
    }

    func GetUserInfodata() -> UserInfoUser? {
//        if let savedPerson = self.mydefault.object(forKey: LoginUserData) as? Data {
//            let decoder = JSONDecoder()
//            if let loadedPerson = try? decoder.decode(UserInfoData.self, from: savedPerson) {
//                return loadedPerson
//            }
//        }
//        return nil
        let personData = self.mydefault.object(forKey: LoginUserData) as! NSData?
        if personData == nil {
            return nil
        }
        else {
            do {
//                let info = try! NSKeyedUnarchiver.unarchivedObject(ofClass: UserInfoData.self, from: personData! as Data)
                let info = NSKeyedUnarchiver.unarchiveObject(with: personData! as Data) as! UserInfoUser
                return info
            }
        }
    }
    
    @objc func UserLogout() {
//        let domain = Bundle.main.bundleIdentifier!
//        self.mydefault.removePersistentDomain(forName: domain)
        
        self.mydefault.set(false, forKey: isUserLogedIn)
        NotificationCenter.default.post(name: Notification.Name(RemoveBdgeNotification), object: nil)
//        self.mydefault.removeObject(forKey: LoginUserData)
//        self.mydefault.synchronize()
        
//        let randomInt = Int.random(in: 0..<3)
//        UserDefaults.standard.setValue(randomInt, forKey: DefaultThemeValue)
        
        AppScene?.SetDashboard()
    }
    
    func SaveUserEmail(email: String) {
        self.mydefault.set(email, forKey: "email")
    }
    
    func GetUserEmail() -> String? {
        guard var email: String = self.mydefault.object(forKey: "email") as? String else {
            return ""
        }
        email = self.mydefault.object(forKey: "email") as? String ?? ""
        return email
    }
    
    func GetUserToken() -> String? {
        let token: String = ""
        guard let rootdata = SharedUserInfo.shared.GetUserInfodata() else {
            return ""
        }
        guard token == rootdata.token else {
            return ""
        }
        return token
    }
    
}
