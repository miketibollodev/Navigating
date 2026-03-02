//
//  RootView.swift
//  NavigatingExamples
//
//  Created by Michael Tibollo on 2026-03-02.
//

import SwiftUI
import Navigating

/// Tab identifiers used in the example app.
public enum TabIdentifier {
    case basics
    case programmatic
    case debug
}

struct RootView: View {
    
    @State var router: Router = .init(level: 0)
    
    var body: some View {
        TabRouter(router: router) {
            TabRoute(id: TabIdentifier.basics) {
                BasicExamplesView()
            } tabItem: {
                Label("Basics", systemImage: "square.grid.2x2.fill")
            }
            
            TabRoute(id: TabIdentifier.programmatic) {
                ProgrammaticExamplesView()
            } tabItem: {
                Label("Programmatic", systemImage: "gearshape.fill")
            }
            
            TabRoute(id: TabIdentifier.debug) {
                DebugExamplesView()
            } tabItem: {
                Label("Debug", systemImage: "ladybug.fill")
            }
        }
    }
}
