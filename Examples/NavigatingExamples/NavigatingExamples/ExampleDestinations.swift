//
//  ExampleDestinations.swift
//  NavigatingExamples
//

import SwiftUI
import Navigating

/// Simple destination view used in the examples.
public struct PushView: View {
    
    public var id = "PushView"
    public var data: [String]
    
    public init(data: [String]) {
        self.data = data
    }
    
    public var body: some View {
        Text("Push View \(Int.random(in: 0...100))")
            .foregroundStyle(Bool.random() ? .red : .blue)
    }
}

