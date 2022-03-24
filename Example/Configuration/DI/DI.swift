//
//  DI.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {

        // core data

        register { CoreDataManager(modelName: "Model") }
        .implements(CoreDataManagerProtocol.self)

        // network client

        register { NetworkClient(host: URL(string: "https://api-dev.applicate.biz/graphql/")!, delegate: MyNetworkClientDelegate()) }

        // data sources

        register { CollectionNetworkSource() }
        .implements(CollectionFetchingDataSourceProtocol.self)

        register { CollectionDBSource() }
        .implements(CollectionDBSourceProtocol.self)

        // repositories

        register { CollectionRepository() }
        .implements(CollectionRepositoryProtocol.self)

        // use cases
        
        register { FetchAllCollectionsUseCase() }
        .implements(FetchAllCollectionsUseCaseProtocol.self)
    }
}
