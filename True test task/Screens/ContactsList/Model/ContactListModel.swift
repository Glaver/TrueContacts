import UIKit

struct ContactListModel {
    var section: [Section]

    struct Section {
        var items: [ContactInfo]
        let title: String
        var type: ContactListModel.ContactType

        var numbersOfItems: Int {
            switch type {
            case .favoritesContacts:
                return 1
            default:
                return items.count
            }
        }
    }

    enum ContactType {
        case favoritesContacts
        case trueContacts
        case phoneContacts

        var title: String {
            switch self {
            case .trueContacts:
                return "Add"
            case .phoneContacts:
                return "Invite"
            case .favoritesContacts:
                return "Contacts"
            }
        }

        var buttonText: String {
            switch self {
            case .trueContacts:
                return "Add"
            case .phoneContacts:
                return "Invite"
            default:
                return ""
            }
        }
    }
}
