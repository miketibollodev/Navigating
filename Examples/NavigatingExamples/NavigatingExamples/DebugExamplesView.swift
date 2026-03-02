//
//  DebugExamplesView.swift
//  NavigatingExamples
//

import SwiftUI
import Navigating

struct DebugExamplesView: View {
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Debugging navigation")
                .font(.headline)
            
            Text("Interact with navigation in other tabs, then inspect the router state below.")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
            
            RouterDebugView()
                .frame(maxHeight: 300)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.secondary.opacity(0.3))
                )
        }
        .padding()
    }
}

