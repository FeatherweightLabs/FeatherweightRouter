import UIKit
import FeatherweightRouter

typealias UIPresenter = Presenter<UIViewController>

func appCoordinator() -> UIViewController {

    var router: Router<UIViewController>!
    let store = AppStore() { router.setRoute($0) }
    router = createRouter(store)

    store.setPath("welcome")

    return router.presentable
}

func createRouter(store: AppStore) -> Router<UIViewController> {

    return Router(tabBarPresenter()).junction([

        Router(navigationPresenter("Welcome")).stack([
            Router(welcomePresenter(store)).route("welcome", children: [
                Router(registrationPresenter(store)).route("welcome/register", children: [
                    Router(step2Presenter(store)).route("welcome/register/step2"),
                ]),
                Router(loginPresenter(store)).route("welcome/login"),
            ])
        ]),

        Router(aboutPresenter(store)).route("about"),
    ])
}
