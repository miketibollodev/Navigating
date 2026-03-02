//
//  ProgrammaticExamplesView.swift
//  NavigatingExamples
//

import SwiftUI
import Navigating

struct ProgrammaticExamplesView: View {
    
    @Environment(Router.self) private var router
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Programmatic navigation")
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Stack control")
                        .font(.headline)
                    Text("Use the Router directly for pop and pop-to-root operations.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        Button("Pop") {
                            router.pop()
                        }
                        Button("Pop to root") {
                            router.popToRoot()
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Tab selection")
                        .font(.headline)
                    Text("Switch tabs by selecting their identifiers on the root router.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        Button("Go to Home") {
                            router.select(tabIdentifier: TabIdentifier.basics)
                        }
                        Button("Go to Debug") {
                            router.select(tabIdentifier: TabIdentifier.debug)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

