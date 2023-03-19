import Contacts
import UIKit

final class FetchContacts {
    func fetchingContacts() -> [ContactInfo]{
        var contacts = [ContactInfo]()
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        do {
            try CNContactStore().enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                contacts.append(ContactInfo(firstName: contact.givenName,
                                            lastName: contact.familyName,
                                            phoneNumber: contact.phoneNumbers.first?.value,
                                            image: contact.imageData != nil ? UIImage(data: contact.imageData!) : nil,
                                            type: .phoneContacts))
            })
        } catch let error {
            print("Failed", error)
        }
        contacts = contacts.sorted {
            if let firstName = $0.firstName, let secondName = $1.firstName {
                return firstName < secondName
            } else {
                return false
            }
        }
        return contacts
    }
}
