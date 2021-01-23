//
//  AuthorizeServiceStarter.swift
//  Incolletion
//
//  Created by Анатолий Ем on 17.01.2021.
//

import Foundation
import RxSwift

protocol AuthorizeServiceStarter {
    func start() -> Observable<InstagramTokenResult>
}
