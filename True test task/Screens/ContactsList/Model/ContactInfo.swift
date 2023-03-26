import Foundation
import UIKit
import Contacts

struct ContactInfo : Identifiable {
    var id = UUID()
    var firstName: String?
    var lastName: String?
    var phoneNumber: CNPhoneNumber?
    var image: UIImage?
    var type: ContactListModel.ContactType

    var hasPhoneNumber: Bool {
        phoneNumber != nil ? true : false
    }

    var hasImageIcon: Bool {
        image != nil ? true : false
    }

    var fullName: String {
        (firstName ?? "") + " " + (lastName ?? "")
    }

    var contactImage: UIImage {
        if let avatarImage = image {
            return avatarImage
        } else {
            return UIImage(named: "empty_avatar")!
        }
    }

    var getInitials: String {
        var initials = ""
        if firstName?.prefix(1) != nil || lastName?.prefix(1) != nil {
            initials = (firstName?.makeInitials() ?? "") + (lastName?.makeInitials() ?? "")
        } else {
            initials = "#"
        }
        return initials
    }

    var cellStyle: Style {
        switch self {
        case _ where phoneNumber == nil && (firstName != nil || lastName != nil):
            return .onlyName
        case _ where (firstName == nil || lastName == nil) && phoneNumber != nil:
            return .onlyPhoneNumber
        default:
            return .nameAndPhonenumber
        }
    }

    enum Style {
        case onlyName
        case onlyPhoneNumber
        case nameAndPhonenumber
    }
}

extension ContactListModel {
    static func mock() -> ContactListModel {
        var favoritesItems: [ContactInfo] {
            [.init(firstName: "You", lastName: "", image: UIImage(named: "you_contact_avatar"), type: .favoritesContacts),
             .init(type: .favoritesContacts),
             .init(type: .favoritesContacts),
             .init(type: .favoritesContacts)]
        }

        var favoritesContacts: ContactListModel.Section {
            .init(items: favoritesItems, title: "", type: .favoritesContacts)
        }

        var trueItems: [ContactInfo] {
            [.init(firstName: "Dan", lastName: "Rosser", image: UIImage(named: "avatar_icon_3"), type: .trueContacts),
             .init(firstName: "Robert", lastName: "Stanton", image: UIImage(named: "avatar_icon_2"), type: .trueContacts),
             .init(firstName: "Daria", lastName: "Lopez", image: UIImage(named: "avatar_icon_1"), type: .trueContacts)]
        }

        var trueContacts: ContactListModel.Section {
            .init(items: trueItems, title: "Contacts on true".uppercased(), type: .trueContacts)
        }

        return .init(section: [favoritesContacts, trueContacts])
    }
}
