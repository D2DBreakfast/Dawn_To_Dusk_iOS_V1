//
//  BannerModel.swift
//  Dawn To Dusk
//
//  Created by Hiren on 29/07/21.
//

import Foundation

// MARK: - BannerModelRootClass
class BannerModelRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: BannerModelData?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: BannerModelData?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - BannerModelData
class BannerModelData: Codable {
    var banner: [BannerModelClass]?

    enum CodingKeys: String, CodingKey {
        case banner = "Banner"
    }

    init(banner: [BannerModelClass]?) {
        self.banner = banner
    }
}

// MARK: - BannerModelBanner
class BannerModelClass: Codable {
    var id: Int?
    var bannerName: String?
    var bannerImage: String?
    var bannerdes: String?
    var bannerTitle: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case bannerName = "banner_name"
        case bannerImage = "banner_image"
        case bannerdes = "banner_des"
        case bannerTitle = "banner_title"
    }

    init(id: Int?, bannerName: String?, bannerImage: String?, bannerdes: String?, bannerTitle: String?) {
        self.id = id
        self.bannerName = bannerName
        self.bannerImage = bannerImage
        self.bannerdes = bannerdes
        self.bannerTitle = bannerTitle
    }
}
