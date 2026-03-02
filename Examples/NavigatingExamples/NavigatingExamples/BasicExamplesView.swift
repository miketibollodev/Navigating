//
//  BasicExamplesView.swift
//  NavigatingExamples
//
//  Created by Michael Tibollo on 2026-03-02.
//

import SwiftUI
import Navigating

struct BasicExamplesView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Basic navigation")
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Push")
                        .font(.headline)
                    Text("Push a new view onto the navigation stack.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    RouterButton(push: PushView(data: ["1", "2", "3"])) {
                        Text("Push example")
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Sheets")
                        .font(.headline)
                    Text("Present a sheet from anywhere in the tree.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    RouterButton(sheet: ModalExampleView()) {
                        Text("Present sheet")
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Full-screen covers")
                        .font(.headline)
                    Text("Present a full-screen cover using the same API.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    RouterButton(fullScreen: ModalExampleView()) {
                        Text("Present full-screen")
                    }
                }
            }
            .padding()
        }
    }
}
