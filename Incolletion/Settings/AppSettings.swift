//
//  AppSettings.swift
//  Incolletion
//
//  Created by Анатолий Ем on 17.01.2021.
//

import Foundation

public enum AppSettings {

    public enum key: String {
            case isLoggedIn = "isLoggedIn"
            case accessToken = "accessToken"
    }

    public static subscript(_ key: key) -> Any? {
        get {
            return UserDefaults.standard.value(forKey: key.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key.rawValue)
        }
    }
}

extension AppSettings {
    public static func boolValue(_ key: key) -> Bool {
        if let value = AppSettings[key] as? Bool {
            return value
        }
        return false
    }
    
    public static func stringValue(_ key: key) -> String? {
        if let value = AppSettings[key] as? String {
            return value
        }
        return nil
    }
    
    public static func intValue(_ key: key) -> Int? {
        if let value = AppSettings[key] as? Int {
            return value
        }
        return nil
    }
}
