import SwiftUI

enum Theme {
    static let accent = Color(hex: "#C9622A")
    static let background = Color(hex: "#141010")
    static let backgroundSecondary = Color(hex: "#1E1714")
    static let card = Color(hex: "#271E19")
    static let textPrimary = Color(hex: "#F5EAE1")
    static let textSecondary = Color(hex: "#C7A78F")

    static let titleFont = Font.system(.title2, design: .serif).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .default)
}

extension Color {
    init(hex: String) {
        let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: h).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
    }
}
