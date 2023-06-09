// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

extension Collection where Element: Identifiable {
    /// Queries the Collection for a specific element based on Identifiable
    ///
    /// - Parameter identifiable: The Element in the Collection you are looking for
    /// - Returns: The index of the Element in the Collection, or Nil if not found.
    func index(matching identifiable: Element) -> Self.Index? {
        return firstIndex { $0.id == identifiable.id }
    }
}

extension RangeReplaceableCollection where Element: Identifiable {
    /// Removes the specified element from the collection, if it found in the collection
    ///
    /// - Parameter element: The Element in which you wish to remove
    mutating func remove(_ element: Element) {
        guard let index = index(matching: element) else { return }
        remove(at: index)
    }
     
    /// Updates the speecific element in the collection.
    /// Since we are using the `Identifiable` protocol here we are able to pass
    /// in the modified element into the collection and replace it.
    ///
    /// - Parameter element: The modified element that needs to be updated in the collection
    /// - Returns: Discardable `false` if the update didn't happen (not found), `true` if the update
    /// did happen
    @discardableResult
    mutating func update(_ element: Element) -> Bool {
        guard let index = index(matching: element) else { return false }
        replaceSubrange(index...index, with: [element])
        return true
    }
}
