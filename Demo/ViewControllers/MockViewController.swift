import UIKit

protocol ProvidesMockData {
    var backgroundColor: (Int, Int, Int) { get }
    var title: String { get }
    var callToActionTitle: String { get }
    var navigateToAction: () -> Void { get }
}

class MockViewController: UIViewController {

    let viewModel: ProvidesMockData

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ viewModel: ProvidesMockData) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = viewModel.title
        tabBarItem.title = viewModel.title
        tabBarItem.image = UIImage(named: "placeholder-icon")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            red: CGFloat(viewModel.backgroundColor.0) / 255,
            green: CGFloat(viewModel.backgroundColor.1) / 255,
            blue: CGFloat(viewModel.backgroundColor.2) / 255,
            alpha: 1)

        titleLabel.text = viewModel.title

        actionButton.setTitle(viewModel.callToActionTitle, forState: .Normal)

        actionButton.addAction(.TouchUpInside) { [unowned self] _ in
            self.viewModel.navigateToAction()
        }
    }
}
