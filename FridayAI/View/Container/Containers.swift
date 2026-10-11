import SwiftUI

struct Container: View {
    let text: String
    let subText: String
    let image: String
    
    var body: some View {
        if #available(iOS 26.0, *) {
            VStack(spacing: 15){
                Image(systemName: image)
                    .foregroundStyle(.blue)
                    .font(.system(size: 20, weight: .bold, design: .serif))
                    .padding()
                    .background(.white)
                    .cornerRadius(100)
                
                Text(text)
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .bold, design: .serif))
                
                Text(subText)
                    .foregroundStyle(.white)
                    .lineLimit(3)
                    .font(.system(size: 14, weight: .medium, design: .serif))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                    
            }
            .padding()
            .frame(maxWidth: .infinity)
            .glassEffect(.regular.interactive(), in: .containerRelative)
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.white, .blue, .cyan],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()

        Container(text: "Type Your Question",
                  subText: "Ask anything that is on your mind, big or small.",
                  image: "paperplane.fill")
            .padding()
    }
}
