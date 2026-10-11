import SwiftUI

struct RootTabView: View {
    var body: some View {
        if #available(iOS 26.0, *) {
            TabView{
                Tab("Chat", systemImage: "bubble.left.and.bubble.right.fill") {
                    MainChatView()
                }
                
                Tab("Journal", systemImage: "book.fill") {
                    SecondView()
                }
            }
            .tabBarMinimizeBehavior(.onScrollDown)
            .tint(.indigo)   
            .frame(maxWidth: .infinity)
        } else {
            // Fallback on earlier versions
        }
        
    }
}

#Preview {
    RootTabView()
}
