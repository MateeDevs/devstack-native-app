//
//  Created by Tomáš Batěk on 24.07.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Utilities
import Foundation

public protocol PagingHandlerDelegate: AnyObject {
    
    associatedtype PagingDataType
    
    /// Defines the function which fetches the associated data for the given page.
    ///
    /// - parameter page: The page which is intended to be loaded
    /// - returns: Fetched data in the `Pages` form
    func fetchData(page: Int) async throws -> Pages<PagingDataType>
    
    /// Gets called when the fetching more progress has changed
    func isFetchingMoreChanged(to: Bool)
    
    /// Gets called when the data has been updated, usually once it's fetched by the `fetchData(page:)` method
    func dataUpdated(_: [PagingDataType])
}

public class AnyPagingHandlerDelegate<T>: PagingHandlerDelegate {
    
    public typealias PagingDataType = T
    
    private let fetchDataCallback: (_ page: Int) async throws -> Pages<T>
    private let isFetchingMoreChangedCallback: (Bool) -> Void
    private let dataUpdatedCallback: ([T]) -> Void
    
    public init<U: PagingHandlerDelegate>(_ pagingHandlerDelegate: U) where U.PagingDataType == T {
        fetchDataCallback = pagingHandlerDelegate.fetchData(page:)
        isFetchingMoreChangedCallback = pagingHandlerDelegate.isFetchingMoreChanged(to:)
        dataUpdatedCallback = pagingHandlerDelegate.dataUpdated(_:)
    }
    
    public func fetchData(page: Int) async throws -> Pages<T> {
        try await fetchDataCallback(page)
    }
    
    public func isFetchingMoreChanged(to value: Bool) {
        isFetchingMoreChangedCallback(value)
    }
    
    public func dataUpdated(_ data: [T]) {
        dataUpdatedCallback(data)
    }
}

@MainActor
public class PagingHandler<T> {

    private var currentPage = 1
    private var totalCount = 0
    private var hasFetchedAll = false // used only when object count is ignored
    
    private let ignoreObjectCount: Bool
    
    /// Creates a PagingHandler that simplifies the paging logic. In your view model, use `initData()` for the initial data fetch
    /// (the first page) and use `handleBottomTouch(originalData:isFetchingMore)` to handle bottom touches. The handler
    /// then decides whether more data should be fetched. The data will be passed to your view model via the delegate.
    /// - parameters:
    ///   - ignoreObjectCount: Whether the `object_count` in the paging data should be ignored. If it's ignored, more data will be fetched
    ///     until an empty array is returned by `fetchData(page:)`. By default, `object_count` is not ignored, so more data will be fetched
    ///     until the amount of fetched data is less than `object_count`.
    public init(ignoreObjectCount: Bool = false) {
        self.ignoreObjectCount = ignoreObjectCount
    }
    
    // swiftlint:disable:next weak_delegate
    public var delegate: AnyPagingHandlerDelegate<T>?
    
    /// Initializes the data (calls the first page)
    public func initData() async throws {
        currentPage = 1
        hasFetchedAll = false
        guard let pages: Pages<T> = try await delegate?.fetchData(page: currentPage) else { return }
        delegate?.dataUpdated(pages.data)
        totalCount = pages.pagination.totalCount
    }
    
    /// Handles when the user touches the bottom of a scroll view
    public func handleBottomTouch(
        originalData: [T],
        isFetchingMore: Bool
    ) async throws {
        guard !isFetchingMore,
              (ignoreObjectCount || originalData.count < totalCount),
              !hasFetchedAll
        else { return }
        
        delegate?.isFetchingMoreChanged(to: true)
        defer {
            delegate?.isFetchingMoreChanged(to: false)
        }

        guard let pages: Pages<T> = try await delegate?.fetchData(page: currentPage + 1) else { return }
        
        if ignoreObjectCount && pages.data.count < pages.pagination.limit {
            hasFetchedAll = true
            return
        }
        
        delegate?.dataUpdated(originalData + pages.data)
        totalCount = pages.pagination.totalCount
        currentPage += 1
    }
}
