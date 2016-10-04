import UIKit
import FeatherweightRouter

func welcomePresenter(_ store: AppStore) -> UIPresenter {

    let viewController = WelcomeViewController(WelcomeViewModel(store: store))

    return Presenter(getPresentable: { viewController })
}
