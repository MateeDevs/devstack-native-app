//
//  Created by Tomáš Batěk on 24.07.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation
import Utilities

public struct NETPagination: Decodable {
    
    // MARK: Stored properties
    public let page: Int
    public let limit: Int
    public let totalCount: Int
    public let lastPage: Int
    
    // MARK: Init
    public init(
        page: Int,
        limit: Int,
        totalCount: Int,
        lastPage: Int
    ) {
        self.page = page
        self.limit = limit
        self.totalCount = totalCount
        self.lastPage = lastPage
    }
}

// Conversion from NetworkModel to DomainModel
extension NETPagination: DomainRepresentable {
    public typealias DomainModel = Pagination
    
    public var domainModel: DomainModel {
        Pagination(
            page: page,
            limit: limit,
            totalCount: totalCount,
            lastPage: lastPage
        )
    }
}

extension NETPagination: Equatable {}

public struct NETPages<T>: Decodable where T: Decodable {
    public let data: [T]
    public let pagination: NETPagination
    
    enum CodingKeys: CodingKey {
        case data
        case page
        case limit
        case totalCount
        case lastPage
    }
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        self.data = try container.decode([T].self, forKey: .data)
        self.pagination = NETPagination(
            page: try container.decode(Int.self, forKey: .page),
            limit: try container.decode(Int.self, forKey: .limit),
            totalCount: try container.decode(Int.self, forKey: .totalCount),
            lastPage: try container.decode(Int.self, forKey: .lastPage)
        )
    }
}

// Conversion from NetworkModel to DomainModel
extension NETPages: DomainRepresentable where T: DomainRepresentable {
    public typealias DomainModel = Pages<T.DomainModel>
    
    public var domainModel: DomainModel {
        get throws { // swiftlint:disable:this implicit_getter
            Pages<T.DomainModel>(
                data: try data.map { try $0.domainModel },
                pagination: pagination.domainModel
            )
        }
    }
}

extension NETPages: Equatable where T: Equatable {
    public static func == (lhs: NETPages<T>, rhs: NETPages<T>) -> Bool {
        lhs.data == rhs.data && lhs.pagination == rhs.pagination
    }
}
