import SwiftUI

struct ContentView: View {
    let ai = AIService()
    @State private var isShowSplash: Bool = true
    
    var body: some View {
        ZStack{
            if isShowSplash == false{
                MainChatView()
                    .transition(.opacity)
            } else {
                SplashView()
                    .transition(.opacity)
            }
        }
        .task {
            try? await Task.sleep(for: .seconds(2.5))
            withAnimation {
                isShowSplash = false
            }
        }
    }
}

#Preview {
    ContentView()
}
