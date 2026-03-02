//
//  Router.swift
//  Navigating
//
//  Created by Michael Tibollo on 2026-03-01.
//

import Foundation
import Observation
import SwiftUI

@Observable
public final class Router {
    
    // MARK: - Properties
    
    private let id: UUID = UUID()
    
    private(set) var isActive: Bool = false
        
    weak public var parent: Router?
    
    public let level: Int
    
    public var selectedTab: AnyHashable?
    
    public let tabIdentifier: AnyHashable?
    
    public var navigationStackPath: [Route] = []
    
    public var presentingSheet: Route?
    
    public var presentingFullScreen: Route?
    
    // MARK: - Initialization
    
    public init(level: Int, tabIdentifier: AnyHashable? = nil) {
        self.level = level
        self.tabIdentifier = tabIdentifier
        self.parent = nil
    }
    
    // MARK: - Navigation
    
    public func select(tabIdentifier: AnyHashable) {
        if level == 0 {
            selectedTab = tabIdentifier
        } else {
            parent?.select(tabIdentifier: tabIdentifier)
            resetContent()
        }
    }
    
    public func push<Content: View>(_ view: Content) {
        navigationStackPath.append(Route(view))
    }
    
    public func present<Content: View>(sheet view: Content) {
        presentingSheet = Route(view)
    }
    
    public func present<Content: View>(fullScreen view: Content) {
        presentingFullScreen = Route(view)
    }
        
    // MARK: - Router Management
    
    private func resetContent() {
        navigationStackPath = []
        presentingSheet = nil
        presentingFullScreen = nil
    }
    
    public func childRouter(for tabIdentifier: AnyHashable? = nil) -> Router {
        let router = Router(level: level + 1, tabIdentifier: tabIdentifier ?? self.tabIdentifier)
        router.parent = self
        return router
    }
    
    public func resignActive() {
        isActive = false
        parent?.setActive()
    }
    
    public func setActive() {
        parent?.resignActive()
        isActive = true
    }
    
}
