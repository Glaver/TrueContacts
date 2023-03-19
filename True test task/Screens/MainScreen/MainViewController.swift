import UIKit

class MainViewController: UIViewController {
    var viewModel: MainViewModel?

    private lazy var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .green
        button.setTitle("Contact permissions", for: .normal)
        button.addTarget(self, action: #selector(contactPermissionTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    private func setupView() {
        view.backgroundColor = .lightGray
        addSubviews()
        configureConstraints()
    }

    @objc func contactPermissionTapped() {
        // TODO: We should refactor this to Router or Coordinator
        let viewModel = ContactsBottomSheetViewModel()
        let vc = ContactsBottomSheetViewController(viewModel: viewModel)
        self.present(vc, animated: true)
    }
}

private extension MainViewController {
    func addSubviews() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
}
