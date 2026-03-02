## Navigating

Lightweight navigation helpers for SwiftUI apps. No route enums, no global coordinators – just a small `Router` object, a few container views, and simple helpers for push, tabs, sheets, and full‑screen covers.

### Installation

Add the package to your project with Swift Package Manager:

```swift
.package(url: "https://github.com/your-org/Navigating.git", from: "1.0.0")
```

Then add `Navigating` as a dependency of your app target.

### Quick start (single stack)

Use `RootRouterView` when you want a single navigation stack with push and modals:

```swift
import Navigating

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            RootRouterView {
                ContentView()
            }
        }
    }
}
```

In `ContentView` you can push and present views using `RouterButton`:

```swift
import Navigating

struct ContentView: View {
    var body: some View {
        VStack {
            RouterButton(push: DetailView()) {
                Text("Push")
            }

            RouterButton(sheet: DetailView()) {
                Text("Present sheet")
            }

            RouterButton(fullScreen: DetailView()) {
                Text("Present full-screen")
            }
        }
    }
}
```

You can style sheets / full screens directly on the destination:

```swift
RouterButton(sheet: DetailView().presentationDetents([.medium, .large])) {
    Text("Custom sheet")
}
```

### Tabs

For tabbed apps, create a root `Router` and use `TabRouter`:

```swift
enum TabIdentifier {
    case home
    case debug
}

struct RootView: View {
    @State var router = Router(level: 0)

    var body: some View {
        TabRouter(router: router) {
            TabRoute(id: TabIdentifier.home) {
                HomeView()
            } tabItem: {
                Label("Home", systemImage: "house.fill")
            }

            TabRoute(id: TabIdentifier.debug) {
                DebugView()
            } tabItem: {
                Label("Debug", systemImage: "ladybug.fill")
            }
        }
    }
}
```

By default, child routers reset their content when switching tabs. To keep per‑tab stacks, initialize the root router with:

```swift
@State var router = Router(level: 0, resetsContentOnTabSelection: false)
```

### Programmatic navigation

If you need direct access to the router, read it from the environment:

```swift
struct SomeView: View {
    @Environment(Router.self) private var router

    var body: some View {
        Button("Pop to root") {
            router.popToRoot()
        }
    }
}
```

Available operations include:

- `push(_:, name:)`
- `present(sheet:, name:)`
- `present(fullScreen:, name:)`
- `presentSheet(_:)` / `presentFullScreen(_:)`
- `pop()` / `popToRoot()`
- `dismissSheet()` / `dismissFullScreen()`
- `resetAll()`

### Debugging

Each `Router` exposes a textual representation of its state:

```swift
print(router.debugSummary)
```

For in‑app inspection, use `RouterDebugView`:

```swift
VStack {
    // your content
    RouterDebugView()
}
```

Routes can optionally be named for easier inspection:

```swift
router.push(DetailView(), name: "detail")
router.present(sheet: SettingsView(), name: "settings-sheet")
```

