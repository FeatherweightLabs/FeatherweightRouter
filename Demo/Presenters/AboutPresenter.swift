import UIKit
import FeatherweightRouter

func aboutPresenter(store: AppStore) -> UIPresenter {

    let viewController = MockViewController(MockViewModel(
        store: store,
        backgroundColor: (128, 192, 256),
        title: "About",
        callToActionTitle: "Go to '/welcome/login/'",
        callToActionRoute: "welcome/login"))

    return Presenter(getPresentable: { viewController })
}
