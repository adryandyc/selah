import SwiftUI

struct VerseDetailView: View {
    let result: SearchResult

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("\(result.book) \(result.chapter):\(result.verse)")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color("Primary"))

            Text(result.text)
                .font(.system(size: 18))
                .foregroundColor(Color("TextPrimary"))
                .multilineTextAlignment(.leading)

            Spacer()
        }
        .padding()
        .navigationTitle("Ayat Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
