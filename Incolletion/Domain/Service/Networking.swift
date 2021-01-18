//
//  Network.swift
//  Incolletion
//
//  Created by Анатолий Ем on 17.01.2021.
//

import Foundation
import RxSwift

enum NetworkMethod: String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
}

protocol Networking {
    func request(url: URL, method: NetworkMethod) -> Observable<Data>
}
