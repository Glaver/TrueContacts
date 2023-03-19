import Foundation

final class ContactsListViewModel {
    private (set) var dataSource: ContactListModel = .mock()

    func updateDataSource(with contacts: [ContactInfo]) {
        let section: ContactListModel.Section = .init(items: contacts, title: "My contacts".uppercased(), type: .phoneContacts)
        dataSource.section.append(section)
    }

    init(contactInfo: [ContactInfo]) {
        updateDataSource(with: contactInfo)
    }
}
