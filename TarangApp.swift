import SwiftUI

@main
struct TarangApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }
            .navigationViewStyle(.stack)
            .preferredColorScheme(.dark)
        }
    }
}
