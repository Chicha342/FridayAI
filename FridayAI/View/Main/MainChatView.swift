import SwiftUI

struct MainChatView: View {
    @State var textFieldText = ""
    @State var isSendButtonVisible: Bool = false
    @State var isLoading: Bool = false
    @State var answerText = ""
    @State var errorMessage = ""
    let ai = AIService()
    
    @State private var messages: [ChatMessage] = []
    @FocusState private var focused: Bool
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .blue, .purple],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack{
                Header()
                
                //MARK: - SCROLL VIEW
                ScrollView{
                    if !answerText.isEmpty {
                        Text(.init(answerText))
                            .foregroundStyle(.black)
                            .font(.system(size: 18, weight: .medium, design: .serif))
                            .padding()
                            .background(.white)
                            .cornerRadius(20)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        VStack(spacing: 30){
                            Container(text: "Type Your Question",
                                      subText: "Ask anything that is on your mind, big or small.",
                                      image: "house")
                            
                            Container(text: "Share a Feeling",
                                      subText: "Tell me what has felt different lately.",
                                      image: "heart.fill")
                            
                            Container(text: "Talk About Fridays",
                                      subText: "Explore what your favorite rituals gave you.",
                                      image: "moon.stars.fill")
                        }
                    }
                }
                .scrollDismissesKeyboard(.interactively)
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                
                
                //MARK: - textfield
                if #available(iOS 26.0, *) {
                    HStack{
                        ZStack{
                            TextField("", text: $textFieldText)
                                .foregroundStyle(.black)
                                .padding()
                                .glassEffect(.regular.interactive(), in: .capsule)
                                .padding(.trailing, textFieldText.isEmpty ? 16:0)
                            
                            if textFieldText.isEmpty{
                                HStack{
                                    Button(action: {
                                        
                                    }, label: {
                                        Image(systemName: "plus")
                                            .foregroundStyle(.black.opacity(0.6))
                                            .padding(.trailing, 5)
                                    })
                                    
                                    
                                    Text("Type you question...")
                                        .foregroundStyle(.black.opacity(0.6))
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                    }, label: {
                                        Image(systemName: "microphone")
                                            .foregroundStyle(.black.opacity(0.6))
                                            .padding(.trailing)
                                    })
                                    
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.leading)
                        
                        if !textFieldText.isEmpty {
                            Button(action: {
                                Task {
                                    sendMessage()
                                }
                            }) {
                                Image(systemName: "paperplane.fill")
                                    .foregroundStyle(.black)
                                    .padding()
                                    .glassEffect(.regular.interactive(), in: .circle)
                                    .padding(.trailing)
                            }
                            .transition(
                                .scale(scale: 0.5)
                                .combined(with: .opacity)
                            )
                        }
                    }
                    .animation(.bouncy(duration: 0.3), value: textFieldText.isEmpty)
                    .padding(.vertical)
                } else {
                    // Fallback on earlier versions
                }
                
            }
            
            if isLoading{
                ProgressView()
                    .tint(.black)
            }
            
        }
    }
    
    private func sendMessage(){
        let question = textFieldText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !question.isEmpty, !isLoading else { return }
        
        textFieldText = ""
        answerText = ""
        errorMessage = ""
        isLoading = true
        
        Task{
            do{
                answerText = try await ai.fetchAI(message: question)
            }catch{
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}

#Preview {
    MainChatView()
}
