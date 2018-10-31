import UIKit
import FeatherweightRouter

typealias UIPresenter = RoutePresenter<UIViewController>

func appCoordinator() -> UIViewController {

    var router: Router<UIViewController, String>!
    let store = AppStore() { _ = router.setRoute($0) }
    router = createRouter(store)

    store.setPath("welcome")

    return router.getPresentable()
}

func createRouter(_ store: AppStore) -> Router<UIViewController, String> {

    return Router(tabBarPresenter()).junction([

        Router(navigationPresenter("Welcome")).stack([
            Router(welcomePresenter(store)).route(predicate: {$0 == "welcome"}, children: [
                Router(registrationPresenter(store)).route(predicate: {$0 == "welcome/register"}, children: [
                    Router(step2Presenter(store)).route(predicate: {$0.matches("welcome/register/step(?<step>\\d+)")}, arguments: { (path) -> RouteArguments in
                        return path.capturedGroups(withRegex: "welcome/register/step(?<step>\\d+)")
                    }),
                ]),
                Router(loginPresenter(store)).route(predicate: {$0 == "welcome/login"}),
            ])
        ]),

        Router(aboutPresenter(store)).route(predicate: {$0 == "about"}),
    ])
}
