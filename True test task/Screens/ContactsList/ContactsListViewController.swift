import UIKit

class ContactsListViewController: UIViewController {
    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(FavoriteContactsTableViewCell.self, forCellReuseIdentifier: "FavoriteContactsTableViewCell")
        tableView.register(PhoneContactsCellTableViewCell.self, forCellReuseIdentifier: "PhoneContactsCellTableViewCell")

        return tableView
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.backgroundColor = .white
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.placeholder = "Add contacts First"
        searchBar.showsCancelButton = false

        return searchBar
    }()

    private lazy var skipButton: UIButton = {
        let skipButton = UIButton()
        skipButton.setTitleColor(UIColor(red: 76 / 255, green: 139 / 255, blue: 255 / 255, alpha: 1), for: .normal)
        skipButton.setTitle("Skip".uppercased(), for: .normal)
        skipButton.titleLabel?.font = .truenoRegular(14)

        return skipButton
    }()

// MARK: - Property

    var viewModel: ContactsListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        setupView()
    }

    private func setupView() {
        addSubviews()
        configureConstraints()
    }
}

// MARK: - UITableViewDataSource

extension ContactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.section[section].numbersOfItems
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.dataSource.section.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectiontitle = viewModel.dataSource.section[section].title
        let view = UIView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        let header = UILabel()

        header.textColor = UIColor(cgColor: .init(red: 116 / 255, green: 116 / 255, blue: 116 / 255, alpha: 1))
        header.font = .truenoRegular(12)
        header.frame = header.bounds
        header.textAlignment = .left
        header.text = sectiontitle

        view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            header.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.dataSource.section[indexPath.section]
        let sectionType = viewModel.dataSource.section[indexPath.section].type

        switch sectionType {
        case .favoritesContacts:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteContactsTableViewCell") as? FavoriteContactsTableViewCell else { return UITableViewCell() }
            cell.render(with: model.items)
            return cell
        case .trueContacts, .phoneContacts:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneContactsCellTableViewCell") as? PhoneContactsCellTableViewCell else { return UITableViewCell() }
            cell.render(with: model.items[indexPath.item])
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension ContactsListViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UISearchBarDelegate

extension ContactsListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
    }
}

private extension ContactsListViewController {
    func addSubviews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])

        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            skipButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: -40),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
