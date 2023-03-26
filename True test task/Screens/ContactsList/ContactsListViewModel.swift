import Foundation

final class ContactsListViewModel {
    private (set) var dataSource: ContactListModel = .mock()
    private (set) lazy var fetchedContaacts: [ContactInfo] = [] // TODO: For filtering logic

    func updateDataSource(with contacts: [ContactInfo]) {
        let section: ContactListModel.Section = .init(items: contacts, title: "My contacts".uppercased(), type: .phoneContacts)
        dataSource.section.append(section)
        fetchedContaacts = contacts
    }

    func showContactsWith(_ text: String) {
        if text == "" {
            for (index, sectionContact) in dataSource.section.enumerated() where sectionContact.type == .phoneContacts {
                dataSource.section[index].items = fetchedContaacts
            }
        } else {
            let filterdContacts = fetchedContaacts.filter {
                guard let name = $0.firstName else { return false }
                return name.hasPrefix(text)
            }
            for (index, sectionContact) in dataSource.section.enumerated() where sectionContact.type == .phoneContacts {
                dataSource.section[index].items = filterdContacts
            }

        }
    }

    init(contactInfo: [ContactInfo]) {
        updateDataSource(with: contactInfo)
    }
}
