import SwiftUI

struct MessageBubles: View {
    let message: ChatMessage
    
    var body: some View {
        HStack(){
            if message.isUser { Spacer(minLength: 50) }
            
            Text(message.text)
                .foregroundStyle(message.isUser ? .white : .black)
                .font(.system(size: 14, weight: .medium, design: .serif))
                .padding()
                .background(message.isUser ? LinearGradient(colors: [.white, .blue, .blue], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [.white, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.1), radius: 6, y: 2)
                .padding(.horizontal)
                .padding(.vertical, 4)
            
            if !message.isUser { Spacer(minLength: 50) }
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

#Preview {
    ZStack{
        Color.blue
            .ignoresSafeArea()
        
        VStack{
            MessageBubles(message: ChatMessage(text: "Hello", isUser: false))
            
            MessageBubles(message: ChatMessage(text: "Hello", isUser: true))
        }
    }
}
