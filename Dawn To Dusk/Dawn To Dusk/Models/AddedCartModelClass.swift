//
//  AddedCartModelClass.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 03/08/21.
//

import Foundation

// MARK: - AddedCartModelRootClass
class AddedCartModelRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: AddedCartModelClass?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: AddedCartModelClass?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - AddedCartModelData
class AddedCartModelClass: Codable {
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }

    init(message: String?) {
        self.message = message
    }
}

