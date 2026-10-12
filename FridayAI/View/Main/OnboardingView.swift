import SwiftUI

struct OnboardingView: View {
    @AppStorage("userName") private var userName = ""
    @State private var nameText = ""
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .blue, .purple],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack{
                HStack{
                    Image(systemName: "apple.intelligence")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                    
                    Text("Friday AI")
                        .foregroundStyle(.white)
                        .font(.system(size: 28, weight: .bold, design: .serif))
                }
                
                Spacer()
                
                Text("Enter you name...")
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .bold, design: .serif))
                
                HStack{
                    if #available(iOS 26.0, *) {
                        TextField(text: $nameText, label: {
                            
                        })
                        .padding()
                        .glassEffect()
                        .cornerRadius(20)
                        
                        
                        Button(action: {
                            let name = nameText.trimmingCharacters(in: .whitespacesAndNewlines)
                            if !name.isEmpty { userName = name }
                        }, label: {
                            Image(systemName: "paperplane.fill")
                                .padding()
                                .foregroundStyle(.black)
                                .glassEffect()
                        })
                        
                    } else {
                        // Fallback on earlier versions
                    }
                }
                .padding(.horizontal)
                
                
                Spacer()
            }
        }
    }
}

#Preview {
    OnboardingView()
}
