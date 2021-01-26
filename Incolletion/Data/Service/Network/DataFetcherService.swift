//
//  DataFetcherService.swift
//  Incolletion
//
//  Created by Анатолий Ем on 17.01.2021.
//

import Foundation
import RxSwift

class DataFetcherService {
    
    var networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    private func buildGETMethodURL(components: [String: String], defaultStringURL: String) -> URL {
        var component = URLComponents(string: defaultStringURL)!
        
        component.queryItems = components.map { return URLQueryItem(name: $0, value: $1) }
        return component.url!
    }
}

extension DataFetcherService: InstagramDataFetcher {
    
    func fetchInstagramToken(with code: String) -> Observable<InstagramTokenResult> {
        let toCleanCode = code.replacingOccurrences(of: "#_", with: "")
        let parameters = [
            "client_id": InstagramApi.instagramAppID,
            "client_secret": InstagramApi.app_secret,
            "code": toCleanCode,
            "grant_type": InstagramApi.grantType,
            "redirect_uri": InstagramApi.redirectURI
        ]
        let url = URL(string: InstagramApi.getAuthStringURL(.access_token))!
        return networkDataFetcher.fetchGenericJSONData(url: url, type: InstagramToken.self, method: .POST, parameters: parameters).map { result -> InstagramTokenResult in
            if result.isSuccess {
                return .success(result.getResult()!)
            }
            return .failure(result.getError()!)
        }
    }
    
    func fetchInstagramUser(with token: InstagramToken) -> Observable<InstagramUserResult> {
        let defaultStringURL = InstagramApi.grathURL + "\(token.userId)"
        let components = [
            "fields" : "id,username,media",
            "access_token" : token.accessToken
        ]
        
        let url = buildGETMethodURL(components: components, defaultStringURL: defaultStringURL)
        return networkDataFetcher.fetchGenericJSONData(url: url,
                                                       type: InstagramUser.self,
                                                       method: .GET,
                                                       parameters: nil).map { result -> InstagramUserResult in
                                                        if result.isSuccess {
                                                        return .success(result.getResult()!)
                                                        }

                                                        return .failure(result.getError()!)
        }
    }
    
    func fetchInstagramMedia(with token: InstagramToken, mediaId: String) -> Observable<InstagramMediaResult> {
        let defaultStringURL = InstagramApi.grathURL + "\(mediaId)"
        let components = [
            "fields" : "caption,id,media_type,media_url,permalink,timestamp,username",
            "access_token" : token.accessToken
        ]
        
        let url = buildGETMethodURL(components: components, defaultStringURL: defaultStringURL)
        
        return networkDataFetcher.fetchGenericJSONData(url: url,
                                                       type: InstagramMedia.self,
                                                       method: .GET,
                                                       parameters: nil).map { result -> InstagramMediaResult in
                                                        if result.isSuccess {
                                                            return .success(result.getResult()!)
                                                        }
                                                        
                                                        return.failure(result.getError()!)
            
        }
    }
}
