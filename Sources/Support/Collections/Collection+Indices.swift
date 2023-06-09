// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

extension Collection {
    typealias IndexesWhereClosure = (Element) throws -> Bool

    
    /// Queries the `Collection` for the indexes of specific `Elements`
    /// - Parameter whereClosure: The closure used to decide if the index should
    ///                 be included in the result array.
    /// - Returns: An array of indexes that match the closure's requirements.
    func indices(where whereClosure: IndexesWhereClosure) rethrows -> [Self.Index] {
        return try indices.compactMap { try whereClosure(self[$0]) ? $0 : nil }
    }
}
