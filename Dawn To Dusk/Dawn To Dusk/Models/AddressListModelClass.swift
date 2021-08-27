//
//  AddressListModelClass.swift
//  Dawn To Dusk
//
//  Created by Hiren on 04/08/21.
//

import Foundation

// MARK: - AddressListRootClass
class AddressListRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: AddressListData?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: AddressListData?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - AddressListData
class AddressListData: Codable {
    var address: [AddressListModelClass]?

    enum CodingKeys: String, CodingKey {
        case address = "address"
    }

    init(address: [AddressListModelClass]?) {
        self.address = address
    }
}

// MARK: - AddressListAddress
class AddressListModelClass: Codable {
    var id: Int?
    var isprimary: Bool?
    var address: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isprimary = "isprimary"
        case address = "address"
    }

    init(id: Int?, isprimary: Bool?, address: String?) {
        self.id = id
        self.isprimary = isprimary
        self.address = address
    }
}

