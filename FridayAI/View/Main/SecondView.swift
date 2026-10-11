import SwiftUI

struct SecondView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .blue, .purple],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            Text("In Work")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    SecondView()
}
