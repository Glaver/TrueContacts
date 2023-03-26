import UIKit
import Contacts

class ContactsBottomSheetViewController: UIViewController {
// MARK: Views

    private lazy var topLineView: UIView = {
        let topLineView = UIView()
        topLineView.backgroundColor = UIColor(red: 238, green: 238, blue: 238, alpha: 1)
        topLineView.layer.cornerRadius = 5

        return topLineView
    }()

    private lazy var contactsImageView: UIImageView = {
        let contactsImageView = UIImageView()
        contactsImageView.backgroundColor = .clear
        contactsImageView.contentMode = .scaleAspectFit
        contactsImageView.image = UIImage(named: "contacts_image")

        return contactsImageView
    }()

    private lazy var contactSearchLabel: UILabel = {
        let contactSearchLabel = UILabel()
        contactSearchLabel.text = "Search Your Contacts"
        contactSearchLabel.textColor = .black
        contactSearchLabel.textAlignment = .center
        contactSearchLabel.font = .truenoSemiBold(18)

        return contactSearchLabel
    }()

    private lazy var descriptionSearchLabel: UILabel = {
        let descriptionSearchLabel = UILabel()
        descriptionSearchLabel.text = "Allow access to your contacts to help us find your friends"
        descriptionSearchLabel.textColor = .black
        descriptionSearchLabel.textAlignment = .center
        descriptionSearchLabel.font = .truenoLight(16)
        descriptionSearchLabel.numberOfLines = 2

        return descriptionSearchLabel
    }()

    private lazy var accessButton: UIButton = {
        let accessButton = UIButton()
        accessButton.backgroundColor = UIColor(red: 76 / 255, green: 139 / 255, blue: 255 / 255, alpha: 1)
        accessButton.layer.cornerRadius = 25
        accessButton.setTitle("Allow access".uppercased(), for: .normal)
        accessButton.titleLabel?.font = .truenoSemiBold(14)
        accessButton.setTitleColor(.white, for: .normal)
        accessButton.addTarget(self, action: #selector(allowAccessButtonTapped), for: .touchUpInside)

        return accessButton
    }()

    private lazy var declineButton: UIButton = {
        let declineButton = UIButton()
        declineButton.backgroundColor = UIColor(red: 238 / 255, green: 238 / 255, blue: 238 / 255, alpha: 1)
        declineButton.layer.cornerRadius = 25
        declineButton.setTitle("Maybe later".uppercased(), for: .normal)
        declineButton.titleLabel?.font = .truenoRegular(14)
        declineButton.setTitleColor(UIColor(red: 69 / 255, green: 69 / 255, blue: 69 / 255, alpha: 1), for: .normal)
        declineButton.addTarget(self, action: #selector(denieAccessButtonTapped), for: .touchUpInside)

        return declineButton
    }()
    
    // MARK: - Property

    var viewModel: ContactsBottomSheetViewModel

    private let sheetTransition = SheetTransition()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    // MARK: - Init

    init(viewModel: ContactsBottomSheetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = sheetTransition

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Buttons targets

    @objc func allowAccessButtonTapped() {
        viewModel.requestAccess() { (contacts, isPermited) in
            if let isAccessPermited = isPermited, isAccessPermited  {
                DispatchQueue.main.async { [weak self] in
                    let viewModel = ContactsListViewModel(contactInfo: contacts)
                    let vc = ContactsListViewController()
                    vc.viewModel = viewModel
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.accessButton.setTitle("Go to settings".uppercased(), for: .normal)
                }
            }
        }
    }

    private func goToSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }

    @objc func denieAccessButtonTapped() {
        self.dismiss(animated: true)
        print("denieAccessButtonTapped")
    }

    // MARK: Setup View

    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        addSubviews()
        configureConstraints()
    }
}

// MARK: - Programmatically Layout

private extension ContactsBottomSheetViewController {
    func addSubviews() {
        view.addSubview(topLineView)
        topLineView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(contactsImageView)
        contactsImageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(contactSearchLabel)
        contactSearchLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(descriptionSearchLabel)
        descriptionSearchLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(declineButton)
        declineButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(accessButton)
        accessButton.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            topLineView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -8),
            topLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topLineView.heightAnchor.constraint(equalToConstant: 4),
            topLineView.widthAnchor.constraint(equalToConstant: 53)
        ])

        NSLayoutConstraint.activate([
            contactsImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            contactsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contactsImageView.heightAnchor.constraint(equalToConstant: 134),
            contactsImageView.widthAnchor.constraint(equalToConstant: 124)
        ])

        NSLayoutConstraint.activate([
            contactSearchLabel.topAnchor.constraint(equalTo: contactsImageView.bottomAnchor,
                                                    constant: 28),
            contactSearchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: 16),
            contactSearchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                         constant: -16)
        ])

        NSLayoutConstraint.activate([
            descriptionSearchLabel.topAnchor.constraint(equalTo: contactSearchLabel.bottomAnchor,
                                                        constant: 16),
            descriptionSearchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                            constant: 16),
            descriptionSearchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                             constant: -16)
        ])

        NSLayoutConstraint.activate([
            declineButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: -54),
            declineButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 50),
            declineButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -50),
            declineButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            accessButton.bottomAnchor.constraint(equalTo: declineButton.topAnchor,
                                                        constant: -16),
            accessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                            constant: 50),
            accessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                             constant: -50),
            accessButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - SheetPresentable

extension ContactsBottomSheetViewController: SheetPresentable {
    var presentationHeight: CGFloat {
        let maxContentHeight: CGFloat = UIScreen.main.bounds.height * 0.55

        return maxContentHeight
    }
}
