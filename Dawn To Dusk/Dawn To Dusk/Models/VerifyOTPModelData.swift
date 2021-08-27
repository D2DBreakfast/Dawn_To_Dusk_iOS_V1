//
//  VerifyOTPModelData.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 03/08/21.
//

import Foundation

// MARK: - VerifyOTPModelRootClass
class VerifyOTPModelRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: VerifyOTPModelData?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: VerifyOTPModelData?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - VerifyOTPModelData
class VerifyOTPModelData: Codable {
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }

    init(message: String?) {
        self.message = message
    }
}
