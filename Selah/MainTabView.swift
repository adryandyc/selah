import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            BibleView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Bible")
                }

            NotesView()
                .tabItem {
                    Image(systemName: "note.text")
                    Text("Notes")
                }

            FavoritesView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }

            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}
