//
//  DummyData.swift
//  Dawn To Dusk
//
//  Created by Hiren on 29/07/21.
//

import Foundation
import SwiftyJSON

func randomString(length: Int? = Int.random(in: 11..<9999)) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length!).map{ _ in letters.randomElement()! })
}
