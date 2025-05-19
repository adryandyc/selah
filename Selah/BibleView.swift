import SwiftUI

struct BibleView: View {
    let bible = BibleDataLoader.loadBibleData()

    let initialBookIndex: Int
    let initialChapterIndex: Int

    @State private var selectedBookIndex: Int
    @State private var selectedChapterIndex: Int
    @State private var highlightedVerse: (book: String, chapter: Int, verse: Int)?

    init(initialBookIndex: Int = 0, initialChapterIndex: Int = 0) {
        self.initialBookIndex = initialBookIndex
        self.initialChapterIndex = initialChapterIndex
        _selectedBookIndex = State(initialValue: initialBookIndex)
        _selectedChapterIndex = State(initialValue: initialChapterIndex)
    }

    var selectedBook: BibleBook? {
        bible.isEmpty ? nil : bible[selectedBookIndex]
    }

    var selectedChapter: BibleChapter? {
        selectedBook?.chapters[selectedChapterIndex]
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(selectedBook?.book ?? "")
                    .font(.headline)
                    .foregroundColor(Color("TextPrimary"))

                Text("\(selectedChapter?.chapter ?? 0)")
                    .font(.headline)
                    .foregroundColor(Color("TextPrimary"))

                Spacer()

                Text("KJV")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color("Card"))
                    .cornerRadius(8)
                    .foregroundColor(Color("TextSecondary"))

                Image(systemName: "speaker.wave.2")
                    .foregroundColor(Color("TextSecondary"))
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color("TextSecondary"))
            }
            .padding()
            .background(Color("Background"))

            Picker("Pilih Kitab", selection: $selectedBookIndex) {
                ForEach(0..<bible.count, id: \.self) { index in
                    Text(bible[index].book).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .font(.system(size: 16))
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(Color("Card"))
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .padding(.horizontal)

            if let selectedBook = selectedBook {
                Picker("Pilih Pasal", selection: $selectedChapterIndex) {
                    ForEach(0..<selectedBook.chapters.count, id: \.self) { index in
                        Text("Pasal \(selectedBook.chapters[index].chapter)").tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .font(.system(size: 16))
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(Color("Card"))
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .padding(.horizontal)
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let verses = selectedChapter?.verses {
                        Text("\(selectedBook?.book ?? "") \(selectedChapter?.chapter ?? 0):1–\(verses.last?.verse ?? 0)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color("TextSecondary"))
                            .padding(.horizontal)

                        ForEach(verses) { verse in
                            HStack(alignment: .top, spacing: 8) {
                                Text("\(verse.verse)")
                                    .font(.footnote)
                                    .foregroundColor(Color("TextSecondary"))
                                    .padding(.top, 2)

                                Text(verse.text)
                                    .font(.system(size: 17))
                                    .foregroundColor(Color("TextPrimary"))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .background(isHighlighted(verse) ? Color("Highlight") : Color.clear)
                            .cornerRadius(8)
                            .onLongPressGesture {
                                highlightedVerse = (
                                    book: selectedBook?.book ?? "",
                                    chapter: selectedChapter?.chapter ?? 0,
                                    verse: verse.verse
                                )
                            }
                        }
                    }
                }
                .padding(.top)
            }

            Spacer()
        }
        .background(Color("Background").ignoresSafeArea())
    }

    func isHighlighted(_ verse: BibleVerse) -> Bool {
        guard let target = highlightedVerse else { return false }
        guard let currentBook = selectedBook?.book,
              let currentChapter = selectedChapter?.chapter else {
            return false
        }

        return currentBook == target.book &&
               currentChapter == target.chapter &&
               verse.verse == target.verse
    }
}
