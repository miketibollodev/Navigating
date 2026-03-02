//
//  RootRouterView.swift
//  Navigating
//
//  A lightweight entry point for apps that want a single navigation
//  hierarchy (push, sheets, full-screen) without manually managing a
//  Router in their own state.
//

import SwiftUI

/// A simple entry point for apps that want a single navigation hierarchy.
public struct RootRouterView<Content: View>: View {
    
    @State private var router: Router
    
    @ViewBuilder private let content: () -> Content
    
    public init(
        resetsContentOnTabSelection: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._router = .init(
            initialValue: Router(
                level: 0,
                tabIdentifier: nil,
                resetsContentOnTabSelection: resetsContentOnTabSelection
            )
        )
        self.content = content
    }
    
    public var body: some View {
        NavigationContainer(parent: router) {
            content()
        }
    }
}

