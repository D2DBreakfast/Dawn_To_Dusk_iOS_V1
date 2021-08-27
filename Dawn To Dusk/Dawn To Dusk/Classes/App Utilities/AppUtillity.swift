//
//  App.swift
//  Dawn To Dusk
//
//  Created by Hiren on 23/07/21.
//

import Foundation
import UIKit

class AppUtillity: NSObject {
    static let shared = AppUtillity()
    
    class var swiftSharedInstance: AppUtillity {
        struct Singleton {
            static let instance = AppUtillity()
        }
        return Singleton.instance
    }
    
    // the sharedInstance class method can be reached from ObjC
    class func sharedInstance() -> AppUtillity {
        return AppUtillity.swiftSharedInstance
    }
    
    func Getheader() -> [String : String] {
        let header : [String : String] = ["Content-Type":"application/json"]
        return header
    }
    
    public func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat.removeWhiteSpace())
        return emailPredicate.evaluate(with: enteredEmail.removeWhiteSpace())
    }
    
    public func validatePhoneNumber(number:String) -> Bool{
        if number.count < 10
        {
            return false;
        }else{
            return true;
        }
    }
    
    public func isObjectNotNil(object:AnyObject!) -> Bool
    {
        if let _:AnyObject = object
        {
            return true
        }
        return false
    }
    
    @objc public func NetworkIndicator(status: Bool) {
        DispatchQueue.main.async {
            
        }
    }
    
}

class AppGesture: UITapGestureRecognizer {
    var indexPath: IndexPath = []
}
