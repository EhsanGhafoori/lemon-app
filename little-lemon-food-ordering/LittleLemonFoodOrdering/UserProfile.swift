import Foundation

struct UserProfile: Codable, Equatable {
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var notifyOrderStatus: Bool
    var notifyPasswordChanges: Bool
    var notifySpecialOffers: Bool
    var notifyNewsletter: Bool
    var avatarData: Data?

    static let empty = UserProfile(
        firstName: "",
        lastName: "",
        email: "",
        phone: "",
        notifyOrderStatus: true,
        notifyPasswordChanges: true,
        notifySpecialOffers: true,
        notifyNewsletter: true,
        avatarData: nil
    )
}
