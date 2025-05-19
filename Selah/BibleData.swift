import Foundation

struct BibleBook: Codable, Identifiable {
    var id: String { book }
    let book: String
    let chapters: [BibleChapter]
}

struct BibleChapter: Codable, Identifiable {
    var id: String { chapter }
    let chapter: String
    let verses: [BibleVerse]
}

struct BibleVerse: Codable, Identifiable {
    var id: String { verse }
    let verse: String
    let text: String
}
