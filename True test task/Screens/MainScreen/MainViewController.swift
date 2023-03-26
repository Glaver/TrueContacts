import UIKit

class MainViewController: UIViewController {
    // MARK: - Views

    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 76 / 255, green: 139 / 255, blue: 255 / 255, alpha: 1)
        button.layer.cornerRadius = 25
        button.setTitle("Allow access".uppercased(), for: .normal)
        button.titleLabel?.font = .truenoSemiBold(14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(contactPermissionTapped), for: .touchUpInside)

        return button
    }()

    var viewModel: MainViewModel?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        addSubviews()
        configureConstraints()
        // Do any additional setup after loading the view.
    }

    @objc func contactPermissionTapped() {
        // TODO: We should refactor this to Router or Coordinator
        let viewModel = ContactsBottomSheetViewModel()
        let vc = ContactsBottomSheetViewController(viewModel: viewModel)
        self.present(vc, animated: true)
    }
}

// MARK: - Programmatically Layout

private extension MainViewController {
    func addSubviews() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 48),
            button.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
}
