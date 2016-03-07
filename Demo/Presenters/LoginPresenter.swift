import UIKit
import FeatherweightRouter

func loginPresenter(store: AppStore) -> UIPresenter {

    let viewController = MockViewController(MockViewModel(
        store: store,
        backgroundColor: (64, 255, 64),
        title: "Login",
        callToActionTitle: "Go to '/welcome/'",
        callToActionRoute: "welcome"))

    return Presenter(getPresentable: { viewController })
}
