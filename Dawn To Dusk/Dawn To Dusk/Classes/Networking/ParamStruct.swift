//
//  ParamStruct.swift
//  Lead
//
//  Created by Hiren Joshi on 22/01/20.
//  Copyright © 2020 Hiren Joshi. All rights reserved.
//

import Foundation

struct RegisterParamDict {
    var fullname: String?
    var email: String?
    var mobile: String?
    var countryCode: String?
    
    var description: [String: Any] {
        get {
            return ["fullName": fullname!, "email":email!, "mobileNo":mobile!, "countryCode":countryCode! ]
         }
    }
}

struct SendotpParamDict {
    var mobile: String?
    var countryCode: String?
    
    var description: [String: Any] {
        get {
            return ["mobileNo":mobile!, "countryCode":countryCode! ]
         }
    }
}

struct OTPcodeParamDict {
    var code: String?
    var mobile: String?
    var countryCode: String?
    
    var description: [String: Any] {
        get {
            return ["mobileOtp":code!, "mobileNo":mobile!, "countryCode":countryCode! ]
         }
    }
}

struct ListingParamDict {
    var CatName: String?
    var SubCatName: String?
    var foodType: String?
    
    var description: [String: Any] {
        get {
            return ["itemMainCategoryName": CatName!, "itemSubCategoryName": SubCatName!, "itemFoodType": foodType!]
         }
    }
}

struct SubCatParamDict {
    var id: String?
    
    var description: [String: Any] {
        get {
            return ["mainCategoryId": id!]
         }
    }
}

struct GlobalSearcgDict {
    var itemSearchKey: String?
    var description: [String: Any] {
        get {
            return ["itemSearchKey": itemSearchKey!]
         }
    }
}

struct UpdateProfileParamDict {
    var fullname: String?
    var email: String?
    var mobile: String?
    
    var description: [String: Any] {
        get {
            return ["fullName": fullname!, "email":email!, "mobileNo":mobile!]
         }
    }
}

struct Place_ToCart_OrderParamDict {
    var itemMainCategoryName: String!
    var itemSubCategoryName: String!
    var itemFoodType: String!
    var itemName: String!
    var itemId: String!
    var itemQuantity: String!
    var itemPrice: String!
    var userId: String!
    
    var description: [String: Any] {
        get {
            return [
                "itemMainCategoryName": itemMainCategoryName!,
                "itemSubCategoryName": itemSubCategoryName!,
                "itemFoodType": itemFoodType!,
                "itemName": itemName!,
                "itemId": itemId!,
                "itemQuantity": itemQuantity!,
                "itemPrice": itemPrice!,
                "userId": userId!
            ]
         }
    }
}

struct MyCartParamDict {
    var userId: String!
    
    var description: [String: Any] {
        get {
            return [
                "userId": userId!
            ]
         }
    }
}

//MARK:- Struct Define for Cart Manage
//MARK:-

struct CartLocation {
    var Address: String?
    var lat: Double?
    var long: Double?
    
    init(Address: String?, lat: Double?, long: Double?) {
        self.Address = Address
        self.lat = lat
        self.long = long
    }
    
}

struct Cartitems {
    var id: String?
    var title: String?
    var price: Double?
    var qty: Int?
    
    init(id: String?, title: String?, price: Double?, qty: Int? = 1) {
        self.id = id
        self.title = title
        self.price = price
        self.qty = qty
    }
}

struct CartCoupon {
    var id: Int?
    var code: String?
    var value: Double?
    var isApply: Bool?
    
    init(id: Int?, code: String?, value: Double?, isApply: Bool? = false) {
        self.id = id
        self.code = code
        self.value = value
        self.isApply = isApply
    }
}

struct SelectedCommunity {
    var id: Int?
    var title: String?
    var lat: Double?
    var long: Double?
    var line1: String?
    var line2: String?
    
    init(id: Int?, title: String?, lat: Double?, long: Double?, line1: String?, line2: String?) {
        self.id = id
        self.title = title
        self.lat = lat
        self.long = long
        self.line1 = line1
        self.line2 = line2
    }
}

struct PaymentMode {
    var id: Int?
    var mode: String?
    var status: Bool?
    
    init(id: Int?, mode: String?, status: Bool?) {
        self.id = id
        self.mode = mode
        self.status = status
    }
}

struct CartInvoice {
    var items: [Cartitems]
    
    init(item: [Cartitems]) {
        self.items = item
    }
}

class CommonSetters {
    lazy var email: String? = {
        return SharedUserInfo.shared.GetUserEmail()
    }()
    lazy var token: String? = {
        return SharedUserInfo.shared.GetUserToken()
    }()
    var isLogin: Bool {
        get {
            if email!.IsStrEmpty() && token!.IsStrEmpty() {
                return true
            }
            else {
                return false
            }
        }
    }
}
