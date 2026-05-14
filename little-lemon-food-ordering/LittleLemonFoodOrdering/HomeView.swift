import SwiftUI
import UIKit

struct HomeView: View {
    @EnvironmentObject private var store: UserProfileStore
    @State private var searchText = ""
    @State private var selectedCategory: MenuCategory = .starters

    private var filteredDishes: [Dish] {
        Dish.sampleMenu.filter { dish in
            let matchesCategory = dish.category == selectedCategory
            let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            if q.isEmpty { return matchesCategory }
            let inText = dish.title.lowercased().contains(q) || dish.description.lowercased().contains(q)
            return matchesCategory && inText
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                header
                hero
                menuBreakdown
                menuList
            }
        }
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        ZStack {
            HStack(spacing: 8) {
                Image(systemName: "leaf.fill")
                    .font(.title2)
                    .foregroundStyle(LLTheme.lemonYellow, LLTheme.darkGreen)
                Text("LITTLE LEMON")
                    .font(.subheadline)
                    .fontDesign(.serif)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(white: 0.28))
            }

            HStack {
                Spacer()
                NavigationLink {
                    ProfileView()
                } label: {
                    profileAvatar
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.white)
    }

    private var profileAvatar: some View {
        Group {
            if let data = store.profile.avatarData,
               let ui = UIImage(data: data) {
                Image(uiImage: ui)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(LLTheme.labelGray.opacity(0.6))
            }
        }
        .frame(width: 40, height: 40)
        .clipShape(Circle())
        .overlay(Circle().stroke(LLTheme.fieldBorder, lineWidth: 1))
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 12) {
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
                        .fixedSize(horizontal: false, vertical: true)
                }
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.15))
                    .frame(width: 100, height: 100)
                    .overlay {
                        Image(systemName: "square.stack.3d.up.fill")
                            .foregroundStyle(.white.opacity(0.85))
                    }
            }

            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(LLTheme.labelGray)
                TextField("Search menu", text: $searchText)
                    .textFieldStyle(.plain)
            }
            .padding(10)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(16)
        .background(LLTheme.heroGreen)
    }

    private var menuBreakdown: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("ORDER FOR DELIVERY!")
                .font(.subheadline)
                .fontWeight(.bold)
                .padding(.horizontal, 16)
                .padding(.top, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(MenuCategory.allCases) { category in
                        Button {
                            selectedCategory = category
                        } label: {
                            Text(category.rawValue)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(selectedCategory == category ? LLTheme.darkGreen : Color(white: 0.92))
                                .foregroundStyle(selectedCategory == category ? Color.white : Color(white: 0.25))
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .background(Color.white)
    }

    private var menuList: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            ForEach(filteredDishes) { dish in
                dishRow(dish)
                Divider().padding(.leading, 16)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 24)
    }

    private func dishRow(_ dish: Dish) -> some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(dish.title)
                    .font(.headline)
                Text(dish.description)
                    .font(.footnote)
                    .foregroundStyle(LLTheme.labelGray)
                    .lineLimit(3)
                Text(dish.price)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.top, 2)
            }
            Spacer(minLength: 8)
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(white: 0.93))
                .frame(width: 88, height: 88)
                .overlay {
                    Image(systemName: dish.systemImage)
                        .font(.title2)
                        .foregroundStyle(LLTheme.darkGreen.opacity(0.7))
                }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(UserProfileStore())
    }
}
