//
//  CouponsModelClass.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 03/08/21.
//

import Foundation

// MARK: - CouponsModelRootClass
class CouponsModelRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: CouponsModelData?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: CouponsModelData?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - CouponsModelData
class CouponsModelData: Codable {
    var coupons: [CouponsModelClass]?

    enum CodingKeys: String, CodingKey {
        case coupons = "coupons"
    }

    init(coupons: [CouponsModelClass]?) {
        self.coupons = coupons
    }
}

// MARK: - CouponsModelClass
class CouponsModelClass: Codable {
    var id: Int?
    var title: String?
    var code: String?
    var shortdesc: String?
    var details: String?
    var terms: String?
    var validdatetime: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case code = "code"
        case shortdesc = "shortdesc"
        case details = "details"
        case terms = "terms"
        case validdatetime = "validdatetime"
    }

    init(id: Int?, title: String?, code: String?, shortdesc: String?, details: String?, terms: String?, validdatetime: String?) {
        self.id = id
        self.title = title
        self.code = code
        self.shortdesc = shortdesc
        self.details = details
        self.terms = terms
        self.validdatetime = validdatetime
    }
}

