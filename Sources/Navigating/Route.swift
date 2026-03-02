//
//  Route.swift
//  Navigating
//
//  Created by Michael Tibollo on 2026-03-02.
//

import SwiftUI

public struct Route: Hashable, Identifiable {
    
    public let id = UUID()

    public let build: () -> AnyView
    
    public init<Content: View>(_ view: Content) {
        self.build = { AnyView(view) }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
