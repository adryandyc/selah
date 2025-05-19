import SwiftUI

struct SearchView: View {
    let bible = BibleDataLoader.loadBibleData()

    @State private var query = ""
    @State private var results: [SearchResult] = []

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                // Header
                HStack {
                    Text("Cari Ayat")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("TextPrimary"))
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("TextPrimary"))
                }
                .padding(.horizontal)
                .padding(.top)

                // Search field
                TextField("Cari kata kunci…", text: $query)
                    .padding(12)
                    .background(Color("Card"))
                    .cornerRadius(10)
                    .foregroundColor(Color("TextPrimary"))
                    .padding(.horizontal)
                    .onChange(of: query) { _ in
                        searchBible()
                    }

                if results.isEmpty && !query.isEmpty {
                    Text("Tidak ada hasil ditemukan.")
                        .foregroundColor(Color("TextSecondary"))
                        .padding()
                } else {
                    List(results) { result in
                        NavigationLink(
                            destination: BibleView(
                                initialBookIndex: getBookIndex(for: result.book),
                                initialChapterIndex: getChapterIndex(for: result.book, chapter: result.chapter)
                            )
                        ) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(result.book) \(result.chapter):\(result.verse)")
                                    .font(.caption)
                                    .foregroundColor(Color("TextSecondary"))

                                Text(result.text)
                                    .font(.body)
                                    .foregroundColor(Color("TextPrimary"))
                            }
                            .padding(.vertical, 4)
                        }
                        .listRowBackground(Color("Background"))
                    }
                    .listStyle(PlainListStyle())
                }

                Spacer()
            }
            .background(Color("Background").ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }

    func searchBible() {
        guard !query.isEmpty else {
            results = []
            return
        }

        var matches: [SearchResult] = []

        for book in bible {
            for chapter in book.chapters {
                for verse in chapter.verses {
                    if verse.text.localizedCaseInsensitiveContains(query) {
                        let match = SearchResult(
                            id: UUID(),
                            book: book.book,
                            chapter: chapter.chapter,
                            verse: verse.verse,
                            text: verse.text
                        )
                        matches.append(match)
                    }
                }
            }
        }

        results = matches
    }

    func getBookIndex(for bookName: String) -> Int {
        return bible.firstIndex(where: { $0.book == bookName }) ?? 0
    }

    func getChapterIndex(for bookName: String, chapter: Int) -> Int {
        guard let book = bible.first(where: { $0.book == bookName }),
              let index = book.chapters.firstIndex(where: { $0.chapter == chapter }) else {
            return 0
        }
        return index
    }
}
