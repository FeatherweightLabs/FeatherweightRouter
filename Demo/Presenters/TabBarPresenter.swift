import UIKit
import FeatherweightRouter

func tabBarPresenter() -> UIPresenter {

    let tabBarController = UITabBarController()

    return RoutePresenter(
        getPresentable: { _ in tabBarController },
        setChild: { tabBarController.selectedViewController = $0 },
        setChildren: { tabBarController.setViewControllers($0, animated: true) })
}
