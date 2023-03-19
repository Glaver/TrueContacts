import UIKit

final class FavoritesCollectionViewCell: UICollectionViewCell {
   // MARK: - Views
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFill
//        avatarImageView.image = UIImage(named: "empty_thumbnail_avatar")

        return avatarImageView
    }()

    private lazy var contactLabel: UILabel = {
        let contactLabel = UILabel()
        contactLabel.textColor = .black
        contactLabel.textAlignment = .center
        contactLabel.font = .truenoRegular(12)

        return contactLabel
    }()

    func render(with model: ContactInfo) {
        avatarImageView.image = model.image != nil ? model.image : UIImage(named: "empty_thumbnail_avatar")
        contactLabel.text = model.fullName
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubviews()
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ProgrammaticLayout

extension FavoritesCollectionViewCell {
    func addSubviews() {
        contentView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(contactLabel)
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            contactLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            contactLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
        ])
    }
}
