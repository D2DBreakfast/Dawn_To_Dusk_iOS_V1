//
//  Constants.swift
//  Dawn To Dusk
//
//  Created by Hiren on 22/07/21.
//

import Foundation
import UIKit

let ThemeSpace                          = ""

let GreenTheme                          = "#127C10"
let OrangeTheme                         = "#ED9015"
let BlueTheme                           = "#2F80ED"
let WhiteColor                          = "#FFFFFF"
let SecondaryWhiteColor                 = "#B5B5B5"
let ThirdWhiteColor                     = "#CDCDCD"
let BlackColor                          = "#0E0E1D"
let SecondaryBlackColor                 = "#1A1A1A"
let ThirdBlackColor                     = "#37526F"
let BorderColor                         = "#BFCEDF"


// iOS
let ThemeGreen                          = UIColor(named: "ThemeColor1")
let ThemeOrange                         = UIColor(named: "ThemeColor2")
let ThemeBlue                           = UIColor(named: "ThemeColor3")
let ModeBG_Color                        = UIColor(named: "ModeColor")
let ModeBorder_Color                    = UIColor(named: "ModeBorderColor")
let WhiteBorderColor                    = UIColor(named: "WhiteBorderColor")
let PrimaryText_Color                   = UIColor(named: "ModePrimarytextColor")
let SecondaryText_Color                 = UIColor(named: "ModeSecondarytextColor")
let ThiredText_Color                    = UIColor(named: "ModeThirdtextColor")
let TBLBackgroundCOlor                  = UIColor(named: "backgroundTBL")

let REGEX_USER_NAME_LIMIT               = "^.{3,10}$"
let REGEX_USER_NAME                     = "[A-Za-z0-9]{3,10}"
let REGEX_TITLE_LIMIT                   = "^.{3,20}$"
let REGEX_TITLE                         = "[A-Za-z0-9]{3,20}"
let REGEX_DATE                          = "[0-9]{1,2}+[/]{1,1}+[0-9]{2,4}"
let REGEX_TIME                          = "[0-9]{1,2}+[:]{1,1}+[0-9]{1,2}"
let REGEX_LOCATION                      = "[A-Za-z0-9,-_ ]{1,50}"
let REGEX_EMAIL                         = "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
let REGEX_PASSWORD_LIMIT                = "^.{6,20}$"
let REGEX_PASSWORD                      = "[A-Za-z0-9]{6,20}"
let REGEX_PHONE_DEFAULT                 = "[0-9]{10,12}"

let ShortVersion                        = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
let DisplayName                         = Bundle.main.infoDictionary?["CFBundleName"] as! String
let BuildName                           = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

// MARK: - -------------------- UIResponder --------------------
// MARK: -

let Screen_width                        = UIScreen.main.bounds.size.width
let Screen_height                       = UIScreen.main.bounds.size.height
let Language                            = NSLocale.preferredLanguages.first
let isIphoneXR                          = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 828, height: 1792)) ?? false
let isIphoneXSMAX                       = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1242, height: 2688)) ?? false
let isXseries                           = isIphoneX || isIphoneXR || isIphoneXSMAX

let TopNavHeight : CGFloat              = isXseries ? 84 : 64
let TabbarHeight : CGFloat              = isXseries ? 83 : 49
let StateBarHeight : CGFloat            = isXseries ? 44 : 20
let NavBarHeight : CGFloat              = isXseries ? 64 : 44
let BottomSafeAreaHeight : CGFloat      = isXseries ? 34 : 0
let BottomTabbarHeight : CGFloat        = isXseries ? 44 : 20
let TopSafeAreaHeight : CGFloat         = isXseries ? 24 : 0
let UnderSafeArea : CGFloat             = isXseries ? 24 : 20

let isIphone5 : Bool                    = (UIScreen.main.bounds.height == 568) //se
let isIphone6 : Bool                    = (UIScreen.main.bounds.height == 667) //6/6s/7/7s/8
let isIphone6P : Bool                   = (UIScreen.main.bounds.height == 736) //6p/6sp/7p/7sp/8p
let isIphoneX : Bool                    = Int((Screen_height / Screen_width) * 100) == 216 ? true : false

let App                                 = UIApplication.shared.delegate as? AppDelegate
let AppScene                            = UIApplication.shared.delegate as? SceneDelegate

// MARK: - -------------------- Check Keys --------------------
// MARK: -

let DefaultThemeValue                   = "RandomTheme"
let BdgeNotification                    = "BadgeCountNotification"
let RemoveBdgeNotification              = "RemoveBdgeNotification"

// MARK:- REST Services Keys <UserInfoData>
let LoginUserData                       = "LoginUserInfo"
let isUserLogedIn                       = "isUserLogedIn"

// MARK: - -------------------- Storyboard --------------------
// MARK: -

func getStroyboard(_ StoryboardWithName: Any) -> UIStoryboard {
    return UIStoryboard(name: StoryboardWithName as! String, bundle: nil)
}
func loadViewController(_ StoryBoardName: Any, _ VCIdentifier: Any) -> UIViewController {
    return getStroyboard(StoryBoardName).instantiateViewController(withIdentifier: VCIdentifier as! String)
}

// MARK: - -------------------- Default Themes --------------------
// MARK: -

func GetDefaultTheme() -> String? {
    let index: Int = UserDefaults.standard.value(forKey: DefaultThemeValue) as! Int
    switch index {
    case 0:
        return GreenTheme
        
    case 1:
        return OrangeTheme
        
    case 2:
        return BlueTheme
        
    default:
        return GreenTheme
    }
}

// MARK: - -------------------- Internet check --------------------
// MARK: -

func IsInternetIssue(message: String?) -> Bool {
    if message!.uppercased() == "Internet connection not available please, check Internet and try agian!".uppercased() {
        return true
    }
    else {
        return false
    }
}

// MARK: - -------------------- Read Files from div --------------------
// MARK: -

func readLocalFile(forName name: String) -> Data? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name,
                                             ofType: "json"),
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
    } catch {
        print(error)
    }
    
    return nil
}

// MARK: - Helper functions for creating encoders and decoders
func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - -------------------- Default Country --------------------
// MARK: -

func getdefaultCountry(countryCode: String? = "AE") -> Country?  {
    let countries = Countries()
    let countryList = countries.countries
    let country = countryList.filter { COU in
        COU.countryCode.uppercased().contains(countryCode!.uppercased())
    }
    return country.first
}


func randomString(length: Int? = Int.random(in: 11..<9999)) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length!).map{ _ in letters.randomElement()! })
}

//https://www.simplifiedcoding.net/php-restful-api-framework-slim-tutorial-1/
//https://github.com/slimphp/Slim
//https://www.w3jar.com/php-login-and-registration-restful-api/
//https://github.com/chandantudu/php-login-registration-api
//https://developer.okta.com/blog/2019/03/08/simple-rest-api-php

//https://github.com/mostlypanda/Node-js-functionalities
//https://heynode.com/tutorial/process-user-login-form-expressjs/
//https://towardsdatascience.com/build-a-rest-api-with-node-express-and-mongodb-937ff95f23a5
//https://medium.com/@sarthakmittal1461/to-build-otp-verification-for-2-way-authentication-using-node-js-and-express-9e8a68836d62

//https://www.loginradius.com/blog/async/hashing-user-passwords-using-bcryptjs/


//Neumorphic UI Design Format
//https://github.com/hmhv/SoftUIView
//https://github.com/costachung/neumorphic
//https://github.com/hirokimu/EMTNeumorphicView
//https://github.com/mumty13/MHSoftUI
//https://github.com/topics/neumorphism-ui?l=swift
//https://github.com/CRED-CLUB/synth-ios
//https://github.com/topics/neumorphism?l=swift&o=asc&s=forks
