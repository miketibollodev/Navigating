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
    case home
    case debug
}

struct RootView: View {
    
    @State var router: Router = .init(level: 0)
    
    var body: some View {
        TabRouter(router: router) {
            TabRoute(id: TabIdentifier.home) {
                BasicExamplesView()
            } tabItem: {
                Label("Home", systemImage: "house.fill")
            }
            
            TabRoute(id: TabIdentifier.debug) {
                DebugExamplesView()
            } tabItem: {
                Label("Debug", systemImage: "ladybug.fill")
            }
        }
    }
}

//
//  Destination.swift
//  Navigating
//
//  Created by Michael Tibollo on 2026-03-01.
//

import Foundation
import Observation
import SwiftUI


// MARK: - Outside of Package

public struct NavButton: View {
    
    @Environment(Router.self) private var router
    
    public var body: some View {
        Button("Push") {
            router.push(
                PushView(data: ["1", "2", "3"])
            )
        }
    }
}


public struct PushView: View {
    
    public var id = "PushView"
    
    public var data: [String]
    
    public var body: some View {
        Text("Push View \(Int.random(in: 0...100))")
            .foregroundStyle(Bool.random() ? .red : .blue)
    }
    
    init(data: [String]) {
        self.data = data
    }
}
