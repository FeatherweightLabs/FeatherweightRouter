import UIKit
import FeatherweightRouter

func tabBarPresenter() -> UIRouterDelegate {

    let tabBarController = UITabBarController()

    return RouterDelegate(
        getPresenter: { tabBarController },
        setChild: { tabBarController.selectedViewController = $0 },
        setChildren: { tabBarController.setViewControllers($0, animated: true) })
}
