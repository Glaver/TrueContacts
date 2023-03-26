import UIKit
import Contacts

class ContactsBottomSheetViewModel {
    private var contacts = [ContactInfo.init(firstName: "", lastName: "", phoneNumber: nil, type: .phoneContacts)] {
        didSet {
            print(contacts)
        }
    }

    func requestAccess(completion: @escaping ([ContactInfo], Bool?) -> Void?) {
        let store = CNContactStore()
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            let contacts = FetchContacts().fetchingContacts()
            completion(contacts, true)
        case .denied:
            store.requestAccess(for: .contacts) { granted, error in
                completion([], granted)
            }
        case .restricted, .notDetermined:
            store.requestAccess(for: .contacts) { granted, error in
                if granted {
                    let contacts = FetchContacts().fetchingContacts()
                    completion(contacts, nil)
                } else {
                    completion([], granted)
                }
            }
        @unknown default:
            print("error")
        }
    }
}

