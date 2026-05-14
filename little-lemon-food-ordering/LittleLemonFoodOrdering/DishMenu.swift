import Foundation

enum MenuCategory: String, CaseIterable, Identifiable {
    case starters = "Starters"
    case mains = "Mains"
    case desserts = "Desserts"
    case drinks = "Drinks"

    var id: String { rawValue }
}

struct Dish: Identifiable, Hashable {
    let id: String
    let title: String
    let description: String
    let price: String
    let category: MenuCategory
    let systemImage: String

    static let sampleMenu: [Dish] = [
        Dish(
            id: "greek-salad",
            title: "Greek Salad",
            description: "The famous greek salad of crispy lettuce, peppers, olives and our Chicago style feta cheese, garnished with crunchy garlic.",
            price: "$12.99",
            category: .starters,
            systemImage: "leaf.fill"
        ),
        Dish(
            id: "bruschetta",
            title: "Bruschetta",
            description: "Our Bruschetta is made from grilled bread that has been smeared with garlic and seasoned with salt and olive oil.",
            price: "$7.99",
            category: .starters,
            systemImage: "birthday.cake"
        ),
        Dish(
            id: "grilled-fish",
            title: "Grilled Fish",
            description: "Barbequed catch of the day, with red onion, crisp capers, chive creme fraiche, lemon and olive oil.",
            price: "$20.00",
            category: .mains,
            systemImage: "fish.fill"
        ),
        Dish(
            id: "pasta",
            title: "Pasta",
            description: "Penne with fried aubergines, tomato sauce, fresh chilli, garlic, basil & salted ricotta cheese.",
            price: "$18.99",
            category: .mains,
            systemImage: "fork.knife"
        ),
        Dish(
            id: "lemon-dessert",
            title: "Lemon Dessert",
            description: "Light and fluffy traditional homemade Italian Lemon and ricotta cake",
            price: "$6.99",
            category: .desserts,
            systemImage: "cup.and.saucer.fill"
        ),
        Dish(
            id: "fresh-juice",
            title: "Fresh Juice",
            description: "Seasonal fruit blend prepared to order.",
            price: "$4.50",
            category: .drinks,
            systemImage: "takeoutbag.and.cup.and.straw.fill"
        ),
    ]
}
