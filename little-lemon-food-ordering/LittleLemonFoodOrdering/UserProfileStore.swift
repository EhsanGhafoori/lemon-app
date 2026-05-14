import Foundation
import SwiftUI

final class UserProfileStore: ObservableObject {
    @Published var hasCompletedOnboarding: Bool
    @Published var profile: UserProfile

    private let defaults = UserDefaults.standard

    private enum Keys {
        static let onboarding = "ll_hasCompletedOnboarding"
        static let profileData = "ll_userProfile_json"
    }

    init() {
        hasCompletedOnboarding = defaults.bool(forKey: Keys.onboarding)
        if let data = defaults.data(forKey: Keys.profileData),
           let decoded = try? JSONDecoder().decode(UserProfile.self, from: data) {
            profile = decoded
        } else {
            profile = .empty
        }
    }

    func reloadFromPersistence() {
        if let data = defaults.data(forKey: Keys.profileData),
           let decoded = try? JSONDecoder().decode(UserProfile.self, from: data) {
            profile = decoded
        }
    }

    func saveProfile() {
        if let data = try? JSONEncoder().encode(profile) {
            defaults.set(data, forKey: Keys.profileData)
        }
    }

    func completeOnboarding(with profile: UserProfile) {
        self.profile = profile
        hasCompletedOnboarding = true
        defaults.set(true, forKey: Keys.onboarding)
        saveProfile()
    }

    func logOut() {
        profile = .empty
        hasCompletedOnboarding = false
        defaults.set(false, forKey: Keys.onboarding)
        defaults.removeObject(forKey: Keys.profileData)
    }
}
