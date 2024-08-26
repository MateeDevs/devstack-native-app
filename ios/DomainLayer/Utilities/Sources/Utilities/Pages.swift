//
//  Created by Tomáš Batěk on 24.07.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation

public struct Pagination {
    
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

extension Pagination: Equatable {}

public struct Pages<T> {
    
    // MARK: Stored properties
    public var data: [T]
    public var pagination: Pagination
    
    // MARK: Init
    public init(data: [T], pagination: Pagination) {
        self.data = data
        self.pagination = pagination
    }
}

extension Pages: Equatable where T: Equatable {}
