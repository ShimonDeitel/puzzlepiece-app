import Foundation

struct Puzzle: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var pieces: Int
    var completedOn: Date
    var hours: Double
}
