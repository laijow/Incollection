//
//  DataFetcherService.swift
//  Incolletion
//
//  Created by Анатолий Ем on 17.01.2021.
//

import Foundation
import RxSwift

class DataFetcherService {
    
    private let networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    private func buildGETMethodURL(components: [String: String], defaultStringURL: String) -> URL {
        var component = URLComponents(string: defaultStringURL)!
        
        component.queryItems = components.map { return URLQueryItem(name: $0, value: $1) }
        return component.url!
    }
}

extension DataFetcherService: InstagramDataFetcher {
    
    func fetchInstagramShortLifeToken(with code: String) -> Observable<InstagramTokenDTOResult> {
        let toCleanCode = code.replacingOccurrences(of: "#_", with: "")
        let parameters = [
            "client_id": InstagramApi.instagramAppID,
            "client_secret": InstagramApi.appSecret,
            "code": toCleanCode,
            "grant_type": InstagramApi.grantType,
            "redirect_uri": InstagramApi.redirectURI
        ]
        let url = URL(string: InstagramApi.getAuthStringURL(.access_token))!
        return networkDataFetcher.fetchGenericJSONData(url: url, type: InstagramTokenDTO.self, method: .POST, parameters: parameters).map { result -> InstagramTokenDTOResult in
            if result.isSuccess {
                return .success(result.getResult()!)
            }
            return .failure(result.getError()!)
        }
    }
    
    func fetchInstagramLongLifeToken(accessToken: String) -> Observable<InstagramTokenDTOResult> {
        let defaultStringURL = InstagramApi.grathURL + "access_token"
        let components = [
            "grant_type" : "ig_exchange_token",
            "client_secret" : InstagramApi.appSecret,
            "access_token" : accessToken
        ]
        
        let url = buildGETMethodURL(components: components, defaultStringURL: defaultStringURL)
        return networkDataFetcher.fetchGenericJSONData(url: url, type: InstagramTokenDTO.self, method: .GET, parameters: nil).map { result -> InstagramTokenDTOResult in
            if result.isSuccess {
                return .success(result.getResult()!)
            }
            return .failure(result.getError()!)
        }
    }
    
    func fetchInstagramRefreshToken(accessToken: String) -> Observable<InstagramTokenDTOResult> {
        let defaultStringURL = InstagramApi.grathURL + "refresh_access_token"
        let components = [
            "grant_type" : "ig_refresh_token",
            "access_token" : accessToken
        ]
        
        let url = buildGETMethodURL(components: components, defaultStringURL: defaultStringURL)
        return networkDataFetcher.fetchGenericJSONData(url: url, type: InstagramTokenDTO.self, method: .GET, parameters: nil).map { result -> InstagramTokenDTOResult in
            if result.isSuccess {
                return .success(result.getResult()!)
            }
            return .failure(result.getError()!)
        }
    }
    
    func fetchInstagramUser(accessToken: String, userId: String) -> Observable<InstagramUserDataResult> {
        let defaultStringURL = InstagramApi.grathURL + userId
        let components = [
            "fields" : "id,username,media",
            "access_token" : accessToken
        ]
        
        let url = buildGETMethodURL(components: components, defaultStringURL: defaultStringURL)
        return networkDataFetcher.fetchGenericJSONData(url: url,
                                                       type: InstagramUserDTO.self,
                                                       method: .GET,
                                                       parameters: nil).map { result -> InstagramUserDataResult in
                                                        if result.isSuccess {
                                                        return .success(result.getResult()!)
                                                        }

                                                        return .failure(result.getError()!)
        }
    }
    
    func fetchInstagramMedia(accessToken: String, mediaId: String) -> Observable<InstagramMediaResult> {
        let defaultStringURL = InstagramApi.grathURL + "\(mediaId)"
        let components = [
            "fields" : "caption,id,media_type,media_url,permalink,timestamp,username,thumbnail_url",
            "access_token" : accessToken
        ]
        
        let url = buildGETMethodURL(components: components, defaultStringURL: defaultStringURL)
        
        return networkDataFetcher.fetchGenericJSONData(url: url,
                                                       type: InstagramMediaDTO.self,
                                                       method: .GET,
                                                       parameters: nil).map { result -> InstagramMediaResult in
                                                        if result.isSuccess {
                                                            return .success(result.getResult()!)
                                                        }
                                                        
                                                        return.failure(result.getError()!)
            
        }
    }
}
