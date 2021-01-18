//
//  NetworkService.swift
//  Incolletion
//
//  Created by Анатолий Ем on 17.01.2021.
//

import Foundation
import RxSwift

class NetworkService: Networking {
    
    func request(url: URL, method: NetworkMethod) -> Observable<Data> {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.rx.response(request: request)
            .asObservable()
            .map { response -> Data in
                return response.data
            }
    }
}
