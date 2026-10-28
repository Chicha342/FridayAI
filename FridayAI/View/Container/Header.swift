import SwiftUI

struct Header: View {
    @Binding var isOpenChats: Bool
    
    var body: some View {
        ZStack{
            HStack{
                Button(action: {
                    withAnimation {
                        isOpenChats.toggle()
                    }
                }, label: {
                    if #available(iOS 26.0, *) {
                        Image(systemName: "line.3.horizontal.decrease")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                            .padding()
                            .glassEffect(.regular.interactive(), in: .circle)
                    } else {
                        // Fallback on earlier versions
                    }
                })
                
                Spacer()
                
                Text("FridayAI")
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    if #available(iOS 26.0, *) {
                        Image(systemName: "gear")
                            .foregroundStyle(.white)
                            .font(.system(size: 15))
                            .padding()
                            .glassEffect(.regular.interactive(), in: .circle)
                    } else {
                        // Fallback on earlier versions
                    }
                })
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    ZStack{
        LinearGradient(colors: [.white, .blue, .cyan],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()
        
        Header(isOpenChats: .constant(false))
    }
}
