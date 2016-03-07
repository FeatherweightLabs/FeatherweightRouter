struct MockViewModel: ProvidesMockData {

    typealias RGBColor = (Int, Int, Int)

    let backgroundColor: RGBColor
    let title: String
    let callToActionTitle: String
    let navigateToAction: () -> Void

    init(store: AppStore, backgroundColor: RGBColor, title: String, callToActionTitle: String,
        callToActionRoute: String) {

            self.backgroundColor = backgroundColor
            self.title = title
            self.callToActionTitle = callToActionTitle

            navigateToAction = {
                store.dispatchRoute(callToActionRoute)
            }
    }
}
