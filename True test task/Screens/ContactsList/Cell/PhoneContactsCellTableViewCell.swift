import UIKit

final class PhoneContactsCellTableViewCell: UITableViewCell {
// MARK: - Views

    private lazy var contactImage: UIImageView = {
        let contactImage = UIImageView()
        contactImage.image = UIImage(named: "empty_avatar")
        contactImage.contentMode = .scaleAspectFill
        contactImage.backgroundColor = .clear
        return contactImage
    }()

    private lazy var contactNameLabel: UILabel = {
        let contactNameLabel = UILabel()
        contactNameLabel.font = .truenoSemiBold(14)
        contactNameLabel.numberOfLines = 1
        contactNameLabel.textAlignment = .left
        contactNameLabel.textColor = .black

        return contactNameLabel
    }()

    private lazy var contactPhoneNumberLabel: UILabel = {
        let contactPhoneNumberLabel = UILabel()
        contactPhoneNumberLabel.font = .truenoRegular(12)
        contactPhoneNumberLabel.numberOfLines = 1
        contactPhoneNumberLabel.textAlignment = .left
        contactPhoneNumberLabel.textColor = UIColor(cgColor: .init(red: 116 / 255, green: 116 / 255, blue: 116 / 255, alpha: 1))

        return contactPhoneNumberLabel
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            contactNameLabel,
            contactPhoneNumberLabel,
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.contentMode = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 0)

        return stackView
    }()

    private lazy var inviteButton: UIButton = {
        let inviteButton = UIButton()
        inviteButton.titleLabel?.font = .truenoRegular(12)
        inviteButton.setTitleColor(.white, for: .normal)
        inviteButton.layer.cornerRadius = 15
        inviteButton.backgroundColor = UIColor(red: 76 / 255, green: 139 / 255, blue: 255 / 255, alpha: 1)

        return inviteButton
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

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

    func render(with model: ContactInfo) {
        if model.hasImageIcon {
            contactImage.image = model.contactImage
        } else {
            contactImage.image = model.contactImage.withTintColor(.random())
            addText(model.getInitials, on: contactImage)
        }

        inviteButton.setTitle(model.type.buttonText, for: .normal)

        switch model.cellStyle {
        case .nameAndPhonenumber:
            contactNameLabel.text = (model.firstName ?? "") + " " + (model.lastName ?? "")
            contactPhoneNumberLabel.text = model.phoneNumber?.stringValue
        case .onlyPhoneNumber:
            contactNameLabel.text = nil
            contactPhoneNumberLabel.textColor = .black
            contactPhoneNumberLabel.font = .truenoSemiBold(14)
        default: break
        }

        contactNameLabel.text = (model.firstName ?? "") + " " + (model.lastName ?? "")

        contactPhoneNumberLabel.text = model.phoneNumber?.stringValue
    }

    private func addText(_ string: String, on image: UIImageView) {
        let label = UILabel()
        label.textColor = .white
        label.text = string
        label.font = .truenoRegular(18)
        label.textAlignment = .center

        image.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: image.centerYAnchor, constant: -2)
        ])
    }

    private func setupView() {
        addSubviews()
        configureConstraints()
    }
}

private extension PhoneContactsCellTableViewCell {
    func addSubviews() {
        contentView.addSubview(contactImage)
        contactImage.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(inviteButton)
        inviteButton.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            contactImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contactImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            contactImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            contactImage.widthAnchor.constraint(equalToConstant: 48),
            contactImage.heightAnchor.constraint(equalToConstant: 48)
        ])

        NSLayoutConstraint.activate([
            inviteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            inviteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            inviteButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
            inviteButton.widthAnchor.constraint(equalToConstant: 73),
            inviteButton.heightAnchor.constraint(equalToConstant: 32)
        ])

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
        ])
    }
}
