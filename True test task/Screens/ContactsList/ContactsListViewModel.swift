import Foundation

final class ContactsListViewModel {
    private (set) var dataSource: ContactListModel = .mock()
    private (set) lazy var fileterdDataSource: [ContactInfo] = []

    func updateDataSource(with contacts: [ContactInfo]) {
        let section: ContactListModel.Section = .init(items: contacts, title: "My contacts".uppercased(), type: .phoneContacts)
        dataSource.section.append(section)
        fileterdDataSource = contacts
    }

    func clearSearch() {
        for section in dataSource.section where section.type == .phoneContacts {
            fileterdDataSource = section.items
        }
    }

    init(contactInfo: [ContactInfo]) {
        updateDataSource(with: contactInfo)
    }
}
