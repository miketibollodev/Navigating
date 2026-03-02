//
//  Route.swift
//  Navigating
//
//  Created by Michael Tibollo on 2026-03-02.
//

import SwiftUI

/// A type-erased destination used internally by the router.
public struct Route: Hashable, Identifiable, CustomStringConvertible {
    
    public let id = UUID()
    
    /// Optional name that can be used for debugging, analytics, or
    /// programmatic navigation decisions.
    public let name: String?

    public let build: () -> AnyView
    
    public init<Content: View>(
        _ view: Content,
        name: String? = nil
    ) {
        self.name = name
        self.build = { AnyView(view) }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public var description: String {
        if let name {
            return "Route(name: \(name), id: \(id))"
        } else {
            return "Route(id: \(id))"
        }
    }
}
