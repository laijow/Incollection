//
//  InstagramApi.swift
//  Incolletion
//
//  Created by Анатолий Ем on 15.01.2021.
//

import Foundation
import UIKit

enum InstagramApiMethod: String {
    case authorize = "oauth/authorize"
    case access_token = "oauth/access_token"
}

class InstagramApi {

    static private let apiURL = "https://api.instagram.com/"
    static private let grathURL = "https://graph.instagram.com/"
    
    static let instagramAppID = "866702484090439"
    static let app_secret = "60d1dcfdd04322d131063875f7fb6409"
    static let redirectURIURLEncoded = "https%3A%2F%2Fwww.google.com%2F"
    static let redirectURI = "https://www.google.com/"
    static let boundary = "boundary=\(NSUUID().uuidString)"
    static let scope = "user_profile,user_media"
    
    static func getStringURL(_ method: InstagramApiMethod) -> String {
        switch method {
        case .authorize: return apiURL + InstagramApiMethod.authorize.rawValue
        case .access_token: return apiURL + InstagramApiMethod.access_token.rawValue
        }
    }
}
