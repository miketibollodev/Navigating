//
//  NavigationContainer.swift
//  Navigating
//
//  Created by Michael Tibollo on 2026-03-01.
//

import SwiftUI

/// A container that hosts a child Router and NavigationStack for a subtree.
public struct NavigationContainer<Content: View>: View {
    
    @State var router: Router
    
    @ViewBuilder var content: () -> Content
    
    public init(
        parent: Router,
        tabIdentifier: AnyHashable? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._router = .init(initialValue: parent.childRouter(for: tabIdentifier))
        self.content = content
    }
    
    public var body: some View {
        InnerContainer(router: router) {
            content()
        }
        .environment(router)
        .onAppear(perform: router.setActive)
        .onDisappear(perform: router.resignActive)
    }
    
}

private struct InnerContainer<Content: View>: View {
    
    @Bindable var router: Router
    
    @ViewBuilder var content: () -> Content

    var body: some View {
        NavigationStack(path: $router.navigationStackPath) {
            content()
                .navigationDestination(for: Route.self) { push in
                    push.build()
                }
        }
        .sheet(item: $router.presentingSheet) { sheet in
            NavigationContainer(parent: router) {
                sheet.build()
            }
        }
        .fullScreenCover(item: $router.presentingFullScreen) { fullScreen in
            NavigationContainer(parent: router) {
                fullScreen.build()
            }
        }
    }
}
