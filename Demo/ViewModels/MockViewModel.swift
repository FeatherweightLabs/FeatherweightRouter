struct MockViewModel: ProvidesMockData {

    typealias RGBColor = (Int, Int, Int)

    let backgroundColor: RGBColor
    let title: String
    let callToActionTitle: String
    let navigateToAction: () -> Void
    var arbitraryArgument: String?

    init(store: AppStore, backgroundColor: RGBColor, title: String, callToActionTitle: String,
         callToActionRoute: String, arbitraryArgument: String? = nil) {

            self.backgroundColor = backgroundColor
            self.title = title
            self.callToActionTitle = callToActionTitle

            navigateToAction = {
                store.dispatchRoute(callToActionRoute)
            }
        
            self.arbitraryArgument = arbitraryArgument
    }
}
