import UIKit

protocol ProvidesColor {
    var backgroundColor: (Int, Int, Int) { get }
}

class WelcomeViewController: UIViewController {

    let viewModel: WelcomeViewModel

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var step2Button: UIButton!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Featherweight Router 👌"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.addAction(events: .touchUpInside) { [unowned self] _ in
            self.viewModel.navigateToLogin()
        }

        registerButton.addAction(events: .touchUpInside) { [unowned self] _ in
            self.viewModel.navigateToRegister()
        }

        step2Button.addAction(events: .touchUpInside) { [unowned self] _ in
            self.viewModel.navigateToStep2()
        }

        view.backgroundColor = UIColor(
            red: CGFloat(viewModel.backgroundColor.0) / 255,
            green: CGFloat(viewModel.backgroundColor.1) / 255,
            blue: CGFloat(viewModel.backgroundColor.2) / 255,
            alpha: 1)
    }
}
