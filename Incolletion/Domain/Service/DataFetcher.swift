//
//  DataFetcher.swift
//  Incolletion
//
//  Created by Анатолий Ем on 17.01.2021.
//

import Foundation
import RxSwift

typealias FetchResult<T> = Result<T, Error>

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(url: URL,
                                            type: T.Type,
                                            method: NetworkMethod,
                                            parameters: [String: String]?) -> Observable<FetchResult<T>>
}
