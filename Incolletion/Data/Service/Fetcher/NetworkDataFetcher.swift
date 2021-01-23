//
//  NetworkDataFetcher.swift
//  Incolletion
//
//  Created by Анатолий Ем on 17.01.2021.
//

import Foundation
import RxSwift

class NetworkDataFetcher: DataFetcher {
    
    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGenericJSONData<T: Decodable>(url: URL,
                                            type: T.Type,
                                            method: NetworkMethod,
                                            parameters: [String: String]?) -> Observable<FetchResult<T>> {
        return networking.request(url: url, method: method, parameters: parameters).map { [weak self] result -> FetchResult<T> in
            guard let self = self else { return .failure(ErrorType.InvalidObject) }
            let decoded = self.decodeJSON(type: type.self, from: result)
            
            return decoded
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> FetchResult<T> {
        let decoder = JSONDecoder()
        guard let data = from else { return .failure(ErrorType.InvalidObject) }
        do {
            let obj = try JSONSerialization.jsonObject(with: data, options: [])
            print(obj)
            let objects = try decoder.decode(type.self, from: data)
            return .success(objects)
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return .failure(jsonError)
        }
    }
}
