import Foundation

extension String {
    func makeInitials() -> String {
        if let firstLetter = self.first {
            return String(firstLetter)
        } else {
            return ""
        }
    }
}
