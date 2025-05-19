import Foundation
class BibleDataLoader {
    static func loadBibleData() -> [BibleBook] {
        guard let url = Bundle.main.url(forResource: "bible-kjv", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([BibleBook].self, from: data) else {
            print("❌ Failed to load or decode JSON.")
            return []
        }
        return decoded
    }
}
