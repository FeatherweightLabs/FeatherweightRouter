# Featherweight Router

Swift based Application State Router

Featherweight Router is a declarative routing handler that decouples ViewControllers from each other. It follows a Coordinator and Presenter pattern, also referred to as Flow Controllers.

Featherweight Router makes an excellent MVVM companion and fits right in with Redux style State Flow and Reactive frameworks.

The Coordinator is constructed by declaring a route hierarchy mapped with a URL structure.

By using mapping UI to URLs, it makes it easy to add automatic URL scheme handling in the future.

## Principle Concepts

### UI is a representation of State

As the State changes over time, so will the UI projection of that State.

Given any State value the UI must be **predictable** and **repeatable**.

### Device dependent state should be separate from the Application State.

Displaying the same State on a phone and tablet for example, can result in different UIs. The device dependent state should remain on that device. An OS X and iOS app can use the same State and logic classes and interchange Routers for representing the State.

### Application State encapsulate Path

If the UI is a projection of State, then the current Path should be included in that State too.

### UI can generate actions to update Path values in the State

The user tapping a back button is easy to capture and generate and action that updates the State Path which causes the UI change. But a user 'swiping' back a view is harder to capture. It should instead generate an action on completion to update the State Path. Then, if the current UI already matches the new State no UI changes are necessary.

### All View components are predictable projections of State

Each view component should be testable and predictable. If any component that makes up the UI is not predictable, then neither is the UI.

### Actual State values should be passed into presenters outside of the Routers

Although the UI should be a projection of State + Path only the Path should be passed to the Router when State changes. Using the Router for State propagation ties the Router to the State. Following the single responsibility principle, the Router only needs updates when the Path changes and callbacks to notify State of Path changes caused by the user outside of the standard Routes (ie, user swiped back in a navigation controller).

## Goal Usage

```swift
import FeatherweightRouter

func appRouter<Store>(store: Store) -> Router<UIViewController> {

    return Router(tabBarPresenter()).junction([
        Router(navigationController(title: "Animals")).stack([
            Router(animalListPresenter(store)).route("animals", [
                Router(animalPresenter(store)).route("(?<id>\\w+)"),
            ]),
        ]),
        Router(navigationController(title: "Zoos")).stack([
            Router(zooListPresenter(store)).route("zoos", [
                Router(zooPresenter(store)).route("(?<id>\\w+)"),
            ]),
        ]),
    ])
}

func appCoordinator() -> UIViewController {

    let store = createStore(appReducer, nil)
    let router = appRouter()
    store.state.map { $0.route }.subscribe(next: router.setRoute)

    return router.presenter
}
```

## Glossary

- **Path / URL**: A String representing the current view or UI state the application is in. This can include hierarchy and view dependent information as parameters or query values. Ie, viewing a user profile
- **State**: A stream of values over time.
- **UI**: User Interface: A visual representation of the State that a user can interact with.

## TODO

In order of achievability:

- [X] Decide if routes and routers should be interchangeable
    - Use a single extendible Router struct type
- [X] Finalise usage specs
    - `Router(presenter:).routerModifier(modifier:paramaters:)`
- [X] Separate all UIKit coupling into protocols
    - Foundation is now the only dependency (for regex matching)
- [X] Extendible router creators
    - `route`, `junction` and `stack` are all extensions on the `Router` type
- [X] AppKit and TVKit support
    - The `Router` accepts a generic presenter type. Even command line presentation is as easy as changing out presenters.
- [ ] Automatic URL scheme support


- Ideal API?
	- StackRouter(:) / Router(stack:)

# License

All content is licensed under the Apache-2.0 unless otherwise stated.

Copyright is owned by Karl Bowden and Featherweight Labs unless otherwise stated.

