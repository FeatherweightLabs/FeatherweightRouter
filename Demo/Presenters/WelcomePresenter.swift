import UIKit
import FeatherweightRouter

func welcomePresenter(store: AppStore) -> UIRouterDelegate {

    let viewController = WelcomeViewController(WelcomeViewModel(store: store))

    return RouterDelegate(getPresenter: { viewController })
}
