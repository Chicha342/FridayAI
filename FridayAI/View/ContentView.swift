import SwiftUI

struct ContentView: View {
    let ai = AIService()
    
    var body: some View {
        VStack {
            Button(action: {
                Task{
                    try await ai.fetchAI(message: "Hello text me")
                }
            }, label: {
                Text("Send")
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
