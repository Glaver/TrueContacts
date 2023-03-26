import UIKit

final class FavoriteContactsTableViewCell: UITableViewCell {
// MARK: - Views

    private lazy var topLabel: UILabel = {
        let topLabel = UILabel()
        topLabel.textColor = .black
        topLabel.textAlignment = .left
        topLabel.text = "Contacts"
        topLabel.font = .truenoExtraBold(32)

        return topLabel
    }()

    private var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "FavoritesCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    // MARK: - Property

    var contactInfo: [ContactInfo] = []

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Render UI

    func render(with model: [ContactInfo]) {
        contactInfo = model
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension FavoriteContactsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contactInfo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = contactInfo[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as? FavoritesCollectionViewCell else { return UICollectionViewCell() }

        cell.render(with: model)

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoriteContactsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = ((collectionView.bounds.width - 16 * 2)) / 4
        return .init(width: cellWidth, height: 104)
    }
}

extension FavoriteContactsTableViewCell: UICollectionViewDelegate {}

// MARK: - Programmatically layout

private extension FavoriteContactsTableViewCell {
    func addSubviews() {
        contentView.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            topLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            topLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16)
        ])

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 114),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
