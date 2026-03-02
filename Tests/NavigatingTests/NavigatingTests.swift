import SwiftUI
import Testing
@testable import Navigating

@Test
func routerPushAndPop() async throws {
    let router = Router(level: 0)
    
    #expect(router.navigationStackPath.isEmpty)
    
    router.push(Text("First"), name: "first")
    router.push(Text("Second"), name: "second")
    
    #expect(router.navigationStackPath.count == 2)
    #expect(router.navigationStackPath.last?.name == "second")
    
    router.pop()
    #expect(router.navigationStackPath.count == 1)
    #expect(router.navigationStackPath.last?.name == "first")
    
    router.popToRoot()
    #expect(router.navigationStackPath.isEmpty)
}

@Test
func routerPresentAndDismissModals() async throws {
    let router = Router(level: 0)
    
    #expect(router.presentingSheet == nil)
    #expect(router.presentingFullScreen == nil)
    
    router.present(sheet: Text("Sheet"), name: "sheet")
    #expect(router.presentingSheet?.name == "sheet")
    
    router.dismissSheet()
    #expect(router.presentingSheet == nil)
    
    router.present(fullScreen: Text("Full"), name: "full")
    #expect(router.presentingFullScreen?.name == "full")
    
    router.dismissFullScreen()
    #expect(router.presentingFullScreen == nil)
}

@Test
func routerResetAllClearsState() async throws {
    let router = Router(level: 0)
    
    router.push(Text("A"))
    router.present(sheet: Text("Sheet"))
    router.present(fullScreen: Text("Full"))
    
    router.resetAll()
    
    #expect(router.navigationStackPath.isEmpty)
    #expect(router.presentingSheet == nil)
    #expect(router.presentingFullScreen == nil)
}

@Test
func routerTabSelectionResetBehavior() async throws {
    // Router that resets child content on tab selection.
    let resettingRouter = Router(level: 0, tabIdentifier: "root", resetsContentOnTabSelection: true)
    let childResetting = resettingRouter.childRouter(for: "child")
    
    childResetting.push(Text("Child"))
    #expect(!childResetting.navigationStackPath.isEmpty)
    
    childResetting.select(tabIdentifier: "other-tab")
    #expect(childResetting.navigationStackPath.isEmpty)
    
    // Router that keeps content on tab selection.
    let preservingRouter = Router(level: 0, tabIdentifier: "root", resetsContentOnTabSelection: false)
    let childPreserving = preservingRouter.childRouter(for: "child")
    
    childPreserving.push(Text("Child"))
    #expect(!childPreserving.navigationStackPath.isEmpty)
    
    childPreserving.select(tabIdentifier: "other-tab")
    #expect(!childPreserving.navigationStackPath.isEmpty)
}

@Test
func routerDebugSummaryContainsKeyInformation() async throws {
    let router = Router(level: 0, tabIdentifier: "root")
    router.push(Text("Detail"), name: "detail")
    router.present(sheet: Text("Sheet"), name: "sheet")
    
    let summary = router.debugSummary
    
    #expect(summary.contains("Router(level: 0"))
    #expect(summary.contains("navigationStackPath:"))
    #expect(summary.contains("detail"))
    #expect(summary.contains("presentingSheet"))
}
