import UIKit
import FeatherweightRouter

func loginPresenter(store: AppStore) -> UIRouterDelegate {

    let viewController = MockViewController(MockViewModel(
        store: store,
        backgroundColor: (64, 255, 64),
        title: "Login",
        callToActionTitle: "Go to '/welcome/'",
        callToActionRoute: "welcome"))

    return RouterDelegate(getPresenter: { viewController })
}
