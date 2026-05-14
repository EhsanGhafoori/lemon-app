import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var store: UserProfileStore
    @State private var pageIndex = 0
    @State private var draft = UserProfile.empty

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $pageIndex) {
                welcomePage.tag(0)
                personalPage.tag(1)
                finalPage.tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))

            Button(action: advance) {
                Text(pageIndex == 2 ? "Get Started" : "Next")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LLTheme.darkGreen)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.white)
        }
        .background(Color.white)
        .onAppear {
            draft = store.profile
            if draft.firstName.isEmpty && draft.lastName.isEmpty && draft.email.isEmpty {
                draft.notifyOrderStatus = true
                draft.notifyPasswordChanges = true
                draft.notifySpecialOffers = true
                draft.notifyNewsletter = true
            }
        }
    }

    private func advance() {
        if pageIndex < 2 {
            pageIndex += 1
        } else {
            store.completeOnboarding(with: draft)
        }
    }

    private var welcomePage: some View {
        VStack(spacing: 20) {
            logoHeader
            Spacer(minLength: 8)
            Text("Welcome to Little Lemon")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text("Discover our Mediterranean menu and order for delivery in a few taps.")
                .font(.body)
                .foregroundStyle(LLTheme.labelGray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            Spacer()
        }
        .padding(.top, 24)
    }

    private var personalPage: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                logoHeader
                heroBanner
                VStack(alignment: .leading, spacing: 16) {
                    fieldLabel("First name *")
                    textField("First name", text: $draft.firstName)
                    fieldLabel("Last name *")
                    textField("Last name", text: $draft.lastName)
                    fieldLabel("Email *")
                    textField("Email", text: $draft.email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
        }
    }

    private var finalPage: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                logoHeader
                Text("Almost there")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 20)
                fieldLabel("Phone number")
                textField("(555) 555-0100", text: $draft.phone)
                    .keyboardType(.phonePad)
                    .padding(.horizontal, 20)
                Text("Email notifications")
                    .font(.headline)
                    .padding(.horizontal, 20)
                VStack(alignment: .leading, spacing: 12) {
                    notificationToggle("Order statuses", isOn: $draft.notifyOrderStatus)
                    notificationToggle("Password changes", isOn: $draft.notifyPasswordChanges)
                    notificationToggle("Special offers", isOn: $draft.notifySpecialOffers)
                    notificationToggle("Newsletter", isOn: $draft.notifyNewsletter)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
            .padding(.top, 8)
        }
    }

    private var logoHeader: some View {
        HStack(spacing: 10) {
            Image(systemName: "leaf.fill")
                .font(.system(size: 36))
                .foregroundStyle(LLTheme.lemonYellow, LLTheme.darkGreen)
            Text("LITTLE LEMON")
                .font(.title3)
                .fontDesign(.serif)
                .fontWeight(.semibold)
                .foregroundStyle(Color(white: 0.28))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }

    private var heroBanner: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Little Lemon")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(LLTheme.lemonYellow)
                Text("Chicago")
                    .font(.title3)
                    .foregroundStyle(.white)
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.95))
            }
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.15))
                .frame(width: 96, height: 96)
                .overlay {
                    Image(systemName: "photo")
                        .foregroundStyle(.white.opacity(0.8))
                }
        }
        .padding(16)
        .background(LLTheme.heroGreen)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 20)
    }

    private func fieldLabel(_ text: String) -> some View {
        Text(text)
            .font(.subheadline)
            .foregroundStyle(LLTheme.labelGray)
    }

    private func textField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(LLTheme.fieldBorder, lineWidth: 1)
            )
    }

    private func notificationToggle(_ title: String, isOn: Binding<Bool>) -> some View {
        Toggle(isOn: isOn) {
            Text(title)
                .font(.subheadline)
        }
        .tint(LLTheme.darkGreen)
    }
}

#Preview {
    OnboardingView()
        .environmentObject(UserProfileStore())
}
