import UIKit
import FeatherweightRouter

func welcomePresenter(store: AppStore) -> UIPresenter {

    let viewController = WelcomeViewController(WelcomeViewModel(store: store))

    return Presenter(getPresentable: { viewController })
}
