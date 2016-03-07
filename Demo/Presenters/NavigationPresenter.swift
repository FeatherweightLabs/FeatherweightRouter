import UIKit
import FeatherweightRouter

func navigationPresenter(title: String) -> UIRouterDelegate {

    let navigationController = UINavigationController()
    navigationController.tabBarItem.title = title
    navigationController.tabBarItem.image = UIImage(named: "placeholder-icon")

    return RouterDelegate(
        getPresenter: { navigationController },
        setChild: { _ in },
        setChildren: { navigationController.setViewControllers($0, animated: true) })
}