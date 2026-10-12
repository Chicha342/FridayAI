import SwiftUI

struct ContentView: View {
    @AppStorage("userName") private var userName = ""
    @State private var isShowSplash = true

    var body: some View {
        ZStack {
            if isShowSplash {
                SplashView().transition(.opacity)
            } else if userName.isEmpty {
                OnboardingView().transition(.opacity)
            } else {
                MainChatView().transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isShowSplash)
        .animation(.easeInOut(duration: 0.5), value: userName.isEmpty)
        .task {
            try? await Task.sleep(for: .seconds(2.5))
            isShowSplash = false
        }
    }
}

#Preview {
    ContentView()
}
