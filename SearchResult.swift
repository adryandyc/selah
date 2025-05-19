import Foundation

struct SearchResult: Identifiable {
    let id: UUID
    let book: String
    let chapter: Int
    let verse: Int
    let text: String
}
