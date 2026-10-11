import SwiftUI

struct ContentView: View {
    let ai = AIService()
    
    var body: some View {
        MainChatView()
    }
}

#Preview {
    ContentView()
}
