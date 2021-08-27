//
//  TrackOrderModelClass.swift
//  Dawn To Dusk
//
//  Created by Hiren on 04/08/21.
//

import Foundation

// MARK: - TrackOrderModelRootClass
class TrackOrderModelRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: TrackOrderModelData?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: TrackOrderModelData?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - TrackOrderModelData
class TrackOrderModelData: Codable {
    var order: TrackOrderModelClass?
    var orderStatus: String?
    var orderdatetime: String?
    var deliveryinfo: String?

    enum CodingKeys: String, CodingKey {
        case order = "order"
        case orderStatus = "orderStatus"
        case orderdatetime = "orderdatetime"
        case deliveryinfo = "deliveryinfo"
    }

    init(order: TrackOrderModelClass?, orderStatus: String?, orderdatetime: String?, deliveryinfo: String?) {
        self.order = order
        self.orderStatus = orderStatus
        self.orderdatetime = orderdatetime
        self.deliveryinfo = deliveryinfo
    }
}

// MARK: - TrackOrderModelOrder
class TrackOrderModelClass: Codable {
    var id: Int?
    var title: String?
    var foodimage: String?
    var gallery: [String]?
    var foodShortdesc: String?
    var foodLongdesc: String?
    var price: Double?
    var cattegory: CategoryModelClass?
    var subCattegory: CategoryModelClass?
    var nutriInfo: String?
    var info: String?
    var isveg: Bool?
    var datetime: String?
    var paymentmode: String?
    var paybleamount: String?
    var paymentStatus: String?
    var recipes: String?
    var deliveryaddress: String?
    var community: CommunityModelClass?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case foodimage = "foodimage"
        case gallery = "gallery"
        case foodShortdesc = "food_shortdesc"
        case foodLongdesc = "food_longdesc"
        case price = "price"
        case cattegory = "cattegory"
        case subCattegory = "sub_cattegory"
        case nutriInfo = "nutri_info"
        case info = "info"
        case isveg = "isveg"
        case datetime = "datetime"
        case paymentmode = "paymentmode"
        case paybleamount = "paybleamount"
        case paymentStatus = "payment_status"
        case recipes = "Recipes "
        case deliveryaddress = "deliveryaddress"
        case community = "Community"
    }

    init(id: Int?, title: String?, foodimage: String?, gallery: [String]?, foodShortdesc: String?, foodLongdesc: String?, price: Double?, cattegory: CategoryModelClass?, subCattegory: CategoryModelClass?, nutriInfo: String?, info: String?, isveg: Bool?, datetime: String?, paymentmode: String?, paybleamount: String?, paymentStatus: String?, recipes: String?, deliveryaddress: String?, community: CommunityModelClass?) {
        self.id = id
        self.title = title
        self.foodimage = foodimage
        self.gallery = gallery
        self.foodShortdesc = foodShortdesc
        self.foodLongdesc = foodLongdesc
        self.price = price
        self.cattegory = cattegory
        self.subCattegory = subCattegory
        self.nutriInfo = nutriInfo
        self.info = info
        self.isveg = isveg
        self.datetime = datetime
        self.paymentmode = paymentmode
        self.paybleamount = paybleamount
        self.paymentStatus = paymentStatus
        self.recipes = recipes
        self.deliveryaddress = deliveryaddress
        self.community = community
    }
}
