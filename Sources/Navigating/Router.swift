//
//  Router.swift
//  Navigating
//
//  Created by Michael Tibollo on 2026-03-01.
//

import Foundation
import Observation
import SwiftUI

/// Observable navigation state used by Navigating for push, tabs, and modals.
@Observable
public final class Router: CustomStringConvertible {
    
    // MARK: - Properties
    
    private let id: UUID = UUID()
    
    private(set) var isActive: Bool = false
        
    weak public var parent: Router?
    
    public let level: Int
    
    public var selectedTab: AnyHashable?
    
    public let tabIdentifier: AnyHashable?
    
    /// Controls whether this router resets its content when triggering a
    /// tab selection from within its hierarchy.
    public var resetsContentOnTabSelection: Bool
    
    public var navigationStackPath: [Route] = []
    
    public var presentingSheet: Route?
    
    public var presentingFullScreen: Route?
    
    // MARK: - Initialization
    
    public init(
        level: Int,
        tabIdentifier: AnyHashable? = nil,
        resetsContentOnTabSelection: Bool = true
    ) {
        self.level = level
        self.tabIdentifier = tabIdentifier
        self.resetsContentOnTabSelection = resetsContentOnTabSelection
        self.parent = nil
    }
    
    // MARK: - Navigation
    
    public func select(tabIdentifier: AnyHashable) {
        if level == 0 {
            selectedTab = tabIdentifier
        } else {
            parent?.select(tabIdentifier: tabIdentifier)
            if resetsContentOnTabSelection {
                resetContent()
            }
        }
    }
    
    public func push<Content: View>(
        _ view: Content,
        name: String? = nil
    ) {
        navigationStackPath.append(Route(view, name: name))
    }
    
    public func present<Content: View>(
        sheet view: Content,
        name: String? = nil
    ) {
        presentingSheet = Route(view, name: name)
    }
    
    public func present<Content: View>(
        fullScreen view: Content,
        name: String? = nil
    ) {
        presentingFullScreen = Route(view, name: name)
    }
        
    // MARK: - Router Management
    
    /// Pops the top-most view from the navigation stack, if any.
    public func pop() {
        _ = navigationStackPath.popLast()
    }
    
    /// Clears the navigation stack back to its root.
    public func popToRoot() {
        navigationStackPath.removeAll()
    }
    
    /// Dismisses the currently presented sheet, if any.
    public func dismissSheet() {
        presentingSheet = nil
    }
    
    /// Dismisses the currently presented full-screen cover, if any.
    public func dismissFullScreen() {
        presentingFullScreen = nil
    }
    
    /// Convenience for presenting a sheet without naming the underlying route.
    public func presentSheet<Content: View>(
        _ view: Content
    ) {
        present(sheet: view)
    }
    
    /// Convenience for presenting a full-screen cover without naming the route.
    public func presentFullScreen<Content: View>(
        _ view: Content
    ) {
        present(fullScreen: view)
    }
    
    /// Resets all navigation state managed by this router.
    public func resetAll() {
        navigationStackPath = []
        presentingSheet = nil
        presentingFullScreen = nil
    }
    
    private func resetContent() {
        resetAll()
    }
    
    public func childRouter(for tabIdentifier: AnyHashable? = nil) -> Router {
        let router = Router(
            level: level + 1,
            tabIdentifier: tabIdentifier ?? self.tabIdentifier,
            resetsContentOnTabSelection: resetsContentOnTabSelection
        )
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
    
    // MARK: - Debug
    
    /// A multi-line textual representation of the router's current state.
    public var debugSummary: String {
        var lines: [String] = []
        lines.append("Router(level: \(level), id: \(id))")
        
        if let tabIdentifier {
            lines.append("  tabIdentifier: \(tabIdentifier)")
        }
        
        if let selectedTab {
            lines.append("  selectedTab: \(selectedTab)")
        }
        
        lines.append("  resetsContentOnTabSelection: \(resetsContentOnTabSelection)")
        lines.append("  isActive: \(isActive)")
        
        if navigationStackPath.isEmpty {
            lines.append("  navigationStackPath: []")
        } else {
            lines.append("  navigationStackPath:")
            for (index, route) in navigationStackPath.enumerated() {
                lines.append("    [\(index)] \(route.description)")
            }
        }
        
        if let presentingSheet {
            lines.append("  presentingSheet: \(presentingSheet.description)")
        } else {
            lines.append("  presentingSheet: nil")
        }
        
        if let presentingFullScreen {
            lines.append("  presentingFullScreen: \(presentingFullScreen.description)")
        } else {
            lines.append("  presentingFullScreen: nil")
        }
        
        return lines.joined(separator: "\n")
    }
    
    public var description: String {
        debugSummary
    }
}
