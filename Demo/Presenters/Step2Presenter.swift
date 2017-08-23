import UIKit
import FeatherweightRouter

func step2Presenter(_ store: AppStore) -> UIPresenter {

    let viewController = MockViewController(MockViewModel(
        store: store,
        backgroundColor: (128, 255, 255),
        title: "ROUTE ARGUMENT: Step = ",
        callToActionTitle: "Go to '/welcome/register/'",
        callToActionRoute: "welcome/register"))

    return RoutePresenter(getPresentable: {
        arguments in
        if let step = arguments.first {
            viewController.setStepNumber(step)
        }
        return viewController
    })
}
