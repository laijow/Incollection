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
    
    private func buildURL(method: InstagramApiMethod, components: [String: String]) -> URL {
        var component = URLComponents(string: InstagramApi.getStringURL(method))!
        
        component.queryItems = components.map { return URLQueryItem(name: $0, value: $1) }
        return component.url!
    }
}

extension DataFetcherService: InstagramDataFetcher {
       
    func fetchInstagramToken(with code: String) -> Observable<InstagramTokenResult> {
        let components = [
            "client_id": InstagramApi.instagramAppID,
            "client_secret": InstagramApi.app_secret,
            "code": code,
            "grant_type": InstagramApi.grantType,
            "redirect_uri": InstagramApi.redirectURI
        ]
        let url = buildURL(method: .access_token, components: components)
        return networkDataFetcher.fetchGenericJSONData(url: url, type: InstagramToken.self, method: .POST).map { result -> InstagramTokenResult in
            if result.isSuccess {
                return .success(result.getResult()!)
            }
            return .failure(result.getError()!)
        }
    }
}
