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
        VStack(spacing: 16) {
            Text("Basic navigation")
                .font(.headline)
            
            RouterButton(push: PushView(data: ["1", "2", "3"])) {
                Text("Push")
            }
            
            RouterButton(sheet: PushView(data: ["A", "B", "C"])) {
                Text("Present sheet")
            }
            
            RouterButton(fullScreen: PushView(data: ["X", "Y", "Z"])) {
                Text("Present full-screen")
            }
        }
        .padding()
    }
}
