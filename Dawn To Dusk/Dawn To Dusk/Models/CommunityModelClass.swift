//
//  CommunityModel.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 03/08/21.
//

import Foundation

// MARK: - CommunityModelRootClass
class CommunityModelRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: CommunityModelData?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: CommunityModelData?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - CommunityModelData
class CommunityModelData: Codable {
    var community: [CommunityModelClass]?

    enum CodingKeys: String, CodingKey {
        case community = "community"
    }

    init(community: [CommunityModelClass]?) {
        self.community = community
    }
}

// MARK: - CommunityModelCommunity
class CommunityModelClass: Codable {
    var id: Int?
    var title: String?
    var address: String?
    var shortdesc: String?
    var lat: Double?
    var long: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case address = "address"
        case shortdesc = "shortdesc"
        case lat = "lat"
        case long = "long"
    }

    init(id: Int?, title: String?, address: String?, shortdesc: String?, lat: Double?, long: Double?) {
        self.id = id
        self.title = title
        self.address = address
        self.shortdesc = shortdesc
        self.lat = lat
        self.long = long
    }
}

