//
//  SceneDelegate.swift
//  Dawn To Dusk
//
//  Created by Hiren on 20/07/21.
//

import UIKit
import SwiftyJSON

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var windowScene: UIWindowScene?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        #if Dev_DEBUG || Dev_RELEASE
        print("Dev Enviournment")
        #elseif UAT_DEBUG || UAT_RELEASE
        print("UAT Enviournment")
        #elseif QAT_DEBUG || QAT_RELEASE
        print("QAT Enviournment")
        #else
        print("Prod Enviournment")
        #endif
        
        self.UpdateTheme()
        UserDefaults.standard.setValue(0, forKey: DefaultThemeValue)
        
        
//        let dict: [String : Any] = [
//            "countryCode": "91",
//            "email": "hiren.joshi@uticome.com",
//            "fullName": "Hiren Joshi",
//            "mobileNo": "8460777809",
//            "mobileOtp": "123456",
//            "registerDate": "",
//            "token": "fsalkfhslakjfblskajfldsahjfisdauhflkjsdahlfkjhsdklafjhsladkfjhsldkajfhklsad",
//            "userId": "23"
//        ]
//        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) else {
//            print("Error: Cannot convert JSON object to Pretty JSON data")
//            return
//        }
//        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//            print("Error: Could print JSON in String")
//            return
//        }
//        let jsonData = prettyPrintedJson.data(using: .utf8)!
//        let json = JSON(jsonData)
//        let obj = UserInfoUser.init(fromJson: json)
//        SharedUserInfo.shared.SaveUserInfodata(info: obj)
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.windowScene = windowScene
        self.window?.windowScene = self.windowScene
        self.GetinitialView()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        UserDefaults.standard.removeObject(forKey: DefaultThemeValue)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


extension SceneDelegate {
    
    @objc public func GetinitialView() {
//        let isFirsttime = SharedUserInfo.shared.isFirstLaunch
//        if isFirsttime {
//            self.GetStarted()
//        }
//        else {
            self.SetDashboard()
//        }
    }
    
    @objc public func SetDashboard() {
        let navigationController = UINavigationController(rootViewController: HomeDashboardVC())
        navigationController.navigationBar.isHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    @objc public func GetLogin() {
        let vc = LoginVC.init(nibName: "LoginVC", bundle: nil)
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.isHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func UpdateTheme() {
        let oldindex: Int? = UserDefaults.standard.value(forKey: DefaultThemeValue) as! Int?
        let randomInt = Int.random(in: 0..<3)
        if oldindex == randomInt {
            self.UpdateTheme()
        }
        else {
            UserDefaults.standard.setValue(randomInt, forKey: DefaultThemeValue)
        }
    }
    
}
