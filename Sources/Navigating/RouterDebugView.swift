//
//  RouterDebugView.swift
//  Navigating
//
//  A lightweight debugging utility that shows the current router state.
//

import SwiftUI

/// A small view that renders the router's debugSummary.
public struct RouterDebugView: View {
    
    @Environment(Router.self) private var router
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            Text(router.debugSummary)
                .font(.system(.footnote, design: .monospaced))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        .background(Color(.systemBackground))
    }
}

