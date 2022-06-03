//
//  Created by Petr Chmelar on 29.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

// Returns true if arrays of tuples contains the same elements.
// https://github.com/apple/swift/issues/46668

// swiftlint:disable large_tuple
 
public func ==<A: Equatable, B: Equatable>(
    lhs: [(A, B)],
    rhs: [(A, B)]
) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lElement) in lhs.enumerated() {
        guard lElement == rhs[idx] else {
            return false
        }
    }
    return true
}

public func ==<A: Equatable, B: Equatable, C: Equatable>(
    lhs: [(A, B, C)],
    rhs: [(A, B, C)]
) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lElement) in lhs.enumerated() {
        guard lElement == rhs[idx] else {
            return false
        }
    }
    return true
}

public func ==<A: Equatable, B: Equatable, C: Equatable, D: Equatable>(
    lhs: [(A, B, C, D)],
    rhs: [(A, B, C, D)]
) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lElement) in lhs.enumerated() {
        guard lElement == rhs[idx] else {
            return false
        }
    }
    return true
}

public func ==<A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable>(
    lhs: [(A, B, C, D, E)],
    rhs: [(A, B, C, D, E)]
) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lElement) in lhs.enumerated() {
        guard lElement == rhs[idx] else {
            return false
        }
    }
    return true
}
