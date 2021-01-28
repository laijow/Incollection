//
//  RegisteringContainer.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
//        registerPlatform()
        registerData()
        registerUI()
        registerDomain()
    }
}
