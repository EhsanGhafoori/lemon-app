import SwiftUI

@main
struct LittleLemonFoodOrderingApp: App {
    @StateObject private var profileStore = UserProfileStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(profileStore)
        }
    }
}

struct RootView: View {
    @EnvironmentObject private var store: UserProfileStore

    var body: some View {
        Group {
            if store.hasCompletedOnboarding {
                NavigationStack {
                    HomeView()
                }
            } else {
                OnboardingView()
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(UserProfileStore())
}
