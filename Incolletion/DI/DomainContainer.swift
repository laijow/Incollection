//
//  DomainContainer.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerDomain() {
        register() { AuthorizeService(router: resolve()) }
            .implements(AuthorizeServiceStarter.self)
            .implements(AuthorizeServiceResolver.self)
            .scope(ResolverScope.application)
        register() { NetworkService() }
            .implements(Networking.self)
            .scope(ResolverScope.application)
    }
}
