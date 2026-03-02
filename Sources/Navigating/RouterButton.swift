//
//  RouterButton.swift
//  Navigating
//
//  Created by Michael Tibollo on 2026-03-02.
//

import SwiftUI

public struct RouterButton<Label: View>: View {
    
    @Environment(Router.self) private var router
    
    private let action: (Router) -> Void
    
    private let label: () -> Label
    
    public init(
        action: @escaping (Router) -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.action = action
        self.label = label
    }
    
    init<Destination: View>(
        push destination: @escaping @autoclosure () -> Destination,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(action: { router in
            router.push(destination())
        }, label: label)
    }
        
    init<Destination: View>(
        sheet destination: @escaping @autoclosure () -> Destination,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(action: { router in
            router.present(sheet: destination())
        }, label: label)
    }
        
    init<Destination: View>(
        fullScreen destination: @escaping @autoclosure () -> Destination,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(action: { router in
            router.present(fullScreen: destination())
        }, label: label)
    }
    
    public var body: some View {
        Button {
            action(router)
        } label: {
            label()
        }
    }
}
