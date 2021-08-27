//
//  NotificationModelClass.swift
//  Dawn To Dusk
//
//  Created by Hiren Joshi on 03/08/21.
//

import Foundation

// MARK: - NotificationRootClass
class NotificationRootClass: Codable {
    var status: Bool?
    var code: Int?
    var message: String?
    var data: NotificationData?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case code = "Code"
        case message = "message"
        case data = "Data"
    }

    init(status: Bool?, code: Int?, message: String?, data: NotificationData?) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - NotificationData
class NotificationData: Codable {
    var notification: [NotificationModelClass]?

    enum CodingKeys: String, CodingKey {
        case notification = "notification"
    }

    init(notification: [NotificationModelClass]?) {
        self.notification = notification
    }
}

// MARK: - Notification
class NotificationModelClass: Codable {
    var id: Int?
    var title: String?
    var shortdesc: String?
    var longdesc: String?
    var gallery: [String]?
    var terms: String?
    var notificationType: String?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case shortdesc = "shortdesc"
        case longdesc = "longdesc"
        case gallery = "gallery"
        case terms = "terms"
        case notificationType = "notification_type"
        case date = "date"
    }

    init(id: Int?, title: String?, shortdesc: String?, longdesc: String?, gallery: [String]?, terms: String?, notificationType: String?, date: String?) {
        self.id = id
        self.title = title
        self.shortdesc = shortdesc
        self.longdesc = longdesc
        self.gallery = gallery
        self.terms = terms
        self.notificationType = notificationType
        self.date = date
    }
}
