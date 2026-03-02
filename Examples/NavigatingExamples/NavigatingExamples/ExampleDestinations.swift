//
//  ExampleDestinations.swift
//  NavigatingExamples
//

import SwiftUI
import Navigating

/// Simple destination used for push and modal examples.
public struct PushView: View {
    
    public var data: [String]
    
    public init(data: [String]) {
        self.data = data
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            Text("Push View")
                .font(.title3)
            Text("Random: \(Int.random(in: 0...100))")
            Text("Data: \(data.joined(separator: \", \"))")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

/// Content shown inside a sheet / full-screen cover.
public struct ModalExampleView: View {
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            Text("Modal content")
                .font(.headline)
            
            Text("You can push further from inside modals using the same Router APIs.")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
            
            RouterButton(push: PushView(data: ["from", "modal"])) {
                Text("Push from modal")
            }
        }
        .padding()
    }
}


