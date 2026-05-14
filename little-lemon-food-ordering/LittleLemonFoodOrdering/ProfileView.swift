import PhotosUI
import SwiftUI
import UIKit

struct ProfileView: View {
    @EnvironmentObject private var store: UserProfileStore
    @Environment(\.dismiss) private var dismiss

    @State private var draft = UserProfile.empty
    @State private var savedSnapshot = UserProfile.empty
    @State private var photoPickerItem: PhotosPickerItem?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Personal information")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 4)

                avatarSection

                labeledField("First name", text: $draft.firstName)
                labeledField("Last name", text: $draft.lastName)
                labeledField("Email", text: $draft.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                labeledField("Phone number", text: $draft.phone)
                    .keyboardType(.phonePad)

                Text("Email notifications")
                    .font(.title3)
                    .fontWeight(.bold)

                notificationRow("Order statuses", isOn: $draft.notifyOrderStatus)
                notificationRow("Password changes", isOn: $draft.notifyPasswordChanges)
                notificationRow("Special offers", isOn: $draft.notifySpecialOffers)
                notificationRow("Newsletter", isOn: $draft.notifyNewsletter)

                Button(role: .none) {
                    store.logOut()
                } label: {
                    Text("Log out")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LLTheme.lemonYellow)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.top, 8)

                HStack(spacing: 12) {
                    Button("Discard changes") {
                        draft = savedSnapshot
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundStyle(LLTheme.darkGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(LLTheme.darkGreen, lineWidth: 2)
                    )

                    Button("Save changes") {
                        store.profile = draft
                        store.saveProfile()
                        savedSnapshot = draft
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LLTheme.darkGreen)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(20)
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.white)
                        .frame(width: 36, height: 36)
                        .background(LLTheme.darkGreen)
                        .clipShape(Circle())
                }
                .accessibilityLabel("Back")
            }
            ToolbarItem(placement: .principal) {
                HStack(spacing: 8) {
                    Image(systemName: "leaf.fill")
                        .foregroundStyle(LLTheme.lemonYellow, LLTheme.darkGreen)
                    Text("LITTLE LEMON")
                        .font(.caption)
                        .fontDesign(.serif)
                        .fontWeight(.semibold)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                avatarThumb
            }
        }
        .onAppear {
            store.reloadFromPersistence()
            draft = store.profile
            savedSnapshot = store.profile
        }
        .onChange(of: photoPickerItem) { _, newItem in
            Task {
                guard let newItem else { return }
                if let data = try? await newItem.loadTransferable(type: Data.self) {
                    await MainActor.run {
                        draft.avatarData = data
                    }
                }
            }
        }
    }

    private var avatarThumb: some View {
        avatarImage(for: draft, size: 36)
    }

    private var avatarSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Avatar")
                .font(.subheadline)
                .foregroundStyle(LLTheme.labelGray)
            avatarImage(for: draft, size: 120)
            HStack(spacing: 12) {
                PhotosPicker(selection: $photoPickerItem, matching: .images) {
                    Text("Change")
                        .font(.subheadline.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(LLTheme.darkGreen)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)

                Button("Remove") {
                    draft.avatarData = nil
                }
                .font(.subheadline.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color.white)
                .foregroundStyle(LLTheme.darkGreen)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(LLTheme.fieldBorder, lineWidth: 1)
                )
            }
        }
    }

    private func avatarImage(for profile: UserProfile, size: CGFloat) -> some View {
        Group {
            if let data = profile.avatarData, let ui = UIImage(data: data) {
                Image(uiImage: ui)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(size * 0.08)
                    .foregroundStyle(LLTheme.labelGray.opacity(0.45))
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(Circle().stroke(LLTheme.fieldBorder, lineWidth: 1))
    }

    private func labeledField(_ title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(LLTheme.labelGray)
            TextField("", text: text)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(LLTheme.fieldBorder, lineWidth: 1)
                )
        }
    }

    private func notificationRow(_ title: String, isOn: Binding<Bool>) -> some View {
        Toggle(isOn: isOn) {
            Text(title)
                .font(.body)
        }
        .toggleStyle(CheckboxToggleStyle())
    }
}

private struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundStyle(configuration.isOn ? LLTheme.darkGreen : LLTheme.labelGray)
                configuration.label
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(UserProfileStore())
    }
}
