import UIKit
import Contacts

class ContactsBottomSheetViewModel {
    private var contacts = [ContactInfo.init(firstName: "", lastName: "", phoneNumber: nil, type: .phoneContacts)] {
        didSet {
            print(contacts)
        }
    }

    func requestAccess(completion: @escaping ([ContactInfo]) -> Void?) {
        let store = CNContactStore()
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            let contacts = FetchContacts().fetchingContacts()
            completion(contacts)
        case .denied:
            store.requestAccess(for: .contacts) { granted, error in
                if granted {
                    let contacts = FetchContacts().fetchingContacts()
                    completion(contacts)
                }
            }
        case .restricted, .notDetermined:
            store.requestAccess(for: .contacts) { granted, error in
                if granted {
                    let contacts = FetchContacts().fetchingContacts()
                    completion(contacts)
                }
            }
        @unknown default:
            print("error")
        }
    }
}

