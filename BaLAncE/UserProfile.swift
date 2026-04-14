import Foundation
import Combine
import UIKit

final class UserProfile: ObservableObject {
    @Published var name: String
    @Published var email: String
    // Store image as Data for easy persistence; optional when not set
    @Published var imageData: Data?

    init(name: String = "", email: String = "", imageData: Data? = nil) {
        self.name = name
        self.email = email
        self.imageData = imageData
    }
}
