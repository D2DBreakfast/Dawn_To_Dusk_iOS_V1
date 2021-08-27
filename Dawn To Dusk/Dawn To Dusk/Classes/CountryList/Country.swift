//
//  Country.swift
//  CountryListExample
//
//  Created by Hiren on 22/07/21.
//

import UIKit

public class Country: NSObject {
    
    public var countryCode: String
    public var phoneExtension: String
    public var Currency: String
    public var symbol: String
    
    public var name: String? {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: countryCode) ?? nil
    }
    
    public var flag: String? {
        return flag(country: countryCode)
    }
    
    init(countryCode: String, phoneExtension: String, Currency: String, symbol: String) {
        self.countryCode = countryCode
        self.phoneExtension = phoneExtension
        self.Currency = Currency
        self.symbol = symbol
    }
    
    private func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}
