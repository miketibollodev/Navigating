//
//  TabRouter.swift
//  Navigating
//
//  Created by Michael Tibollo on 2026-03-01.
//

import SwiftUI

/// Result builder used to declare tab routes.
@resultBuilder
public struct TabRouteBuilder {
    
    public static func buildBlock(
        _ components: TabRoute...
    ) -> [TabRoute] {
        components
    }
}


/// A TabView-based router that wires each tab into its own navigation stack.
public struct TabRouter: View {
    
    @Bindable private var router: Router
    
    private let routes: [TabRoute]
    
    public init(
        router: Router,
        @TabRouteBuilder tabs: () -> [TabRoute]
    ) {
        self._router = .init(router)
        self.routes = tabs()
    }
    
    public var body: some View {
        TabView(selection: $router.selectedTab) {
            ForEach(routes, id: \.id) { route in
                NavigationContainer(
                    parent: router,
                    tabIdentifier: route
                ) {
                    route.build()
                }
                .tabItem {
                    route.tabItem()
                }
                .tag(route.id)
            }
        }
    }
}


/// A single tab configuration (id, content, and tab item view).
public struct TabRoute: Hashable, Identifiable {

    public let id: AnyHashable
    
    public let build: () -> AnyView
    
    public let tabItem: () -> AnyView

    public init<ID: Hashable, Content: View, TabItem: View>(
        id: ID,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder tabItem: @escaping () -> TabItem
    ) {
        self.id = AnyHashable(id)
        self.build = { AnyView(content()) }
        self.tabItem = { AnyView(tabItem()) }
    }

    public init<Content: View, TabItem: View>(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder tabItem: @escaping () -> TabItem
    ) {
        self.id = AnyHashable(UUID())
        self.build = { AnyView(content()) }
        self.tabItem = { AnyView(tabItem()) }
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
