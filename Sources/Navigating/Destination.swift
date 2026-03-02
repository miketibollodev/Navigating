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

public struct RootView: View {
    
    @State var router: Router = .init(level: 0)
    
    public var body: some View {
        TabRouter(router: router) {
            TabRoute {
                VStack {
                    NavButton()
                    
                    Button("Info") {
                        print(router.navigationStackPath)
                        print(router.level)
                    }
                }
            } tabItem: {
                Text("Home")
            }

            TabRoute {
                NavButton()
            } tabItem: {
                Text("Profile")
            }
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
