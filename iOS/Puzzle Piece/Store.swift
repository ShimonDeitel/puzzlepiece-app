import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published private(set) var items: [Puzzle] = []
    @Published var isPro: Bool = false

    static let freeLimit = 25

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("puzzlepiece", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Puzzle) {
        guard canAddMore else { return }
        items.append(item)
        save()
    }

    func update(_ item: Puzzle) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Puzzle) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Puzzle].self, from: data) {
            items = decoded
        } else {
            items = Store.seedData
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }

    static var seedData: [Puzzle] {
        [
        Puzzle(id: UUID(), title: "Starry Night", pieces: 1000, completedOn: ISO8601DateFormatter().date(from: "2026-05-01T00:00:00Z") ?? Date(), hours: 6.5),
        Puzzle(id: UUID(), title: "Ocean Map", pieces: 500, completedOn: ISO8601DateFormatter().date(from: "2026-06-01T00:00:00Z") ?? Date(), hours: 3.0),
        Puzzle(id: UUID(), title: "Cabin Snow", pieces: 300, completedOn: ISO8601DateFormatter().date(from: "2026-06-20T00:00:00Z") ?? Date(), hours: 2.0)
        ]
    }
}
