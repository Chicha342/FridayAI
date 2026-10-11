import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .blue, .purple],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack{
                Image(systemName: "apple.intelligence")
                    .foregroundStyle(.white)
                    .font(.system(size: 20))
                
                Text("Friday AI")
                    .foregroundStyle(.white)
                    .font(.system(size: 28, weight: .bold, design: .serif))
            }
        }
    }
}

#Preview {
    SplashView()
}
