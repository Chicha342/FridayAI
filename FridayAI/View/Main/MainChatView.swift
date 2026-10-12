import SwiftUI

struct MainChatView: View {
    @AppStorage("userName") private var userName = ""
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
                ScrollViewReader { proxy in
                    ScrollView{
                        if !messages.isEmpty {
                            ForEach(messages) { message in
                                MessageBubles(message: message).id(message.id)
                            }
                        } else {
                            if !userName.isEmpty{
                                Text("Hi, \(userName)")
                                    .font(.system(size: 20, weight: .bold, design: .serif))
                                    .foregroundStyle(.white)
                            }
                            
                            contaiersBubbles()
                        }
                    }
                    .scrollDismissesKeyboard(.interactively)
                    .scrollIndicators(.hidden)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal).onChange(of: messages.count) { scrollToEnd(proxy) }
                    .onChange(of: isLoading) { scrollToEnd(proxy) }
                }
                
                
                
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
            
        }
    }
    
    func contaiersBubbles() -> some View{
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
    
    private func sendMessage(){
        let question = textFieldText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !question.isEmpty, !isLoading else { return }
        
        focused = false
        textFieldText = ""
        errorMessage = ""
        messages.append(ChatMessage(text: question, isUser: true))
        isLoading = true
        
        let history = messages
        
        Task{
            do{
                answerText = try await ai.fetchAI(history: history, userName: userName)
                messages.append(ChatMessage(text: answerText, isUser: false))
            }catch{
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    private func scrollToEnd(_ proxy: ScrollViewProxy) {
        withAnimation(.easeOut(duration: 0.25)) {
            if isLoading { proxy.scrollTo("loader", anchor: .bottom) }
            else if let last = messages.last { proxy.scrollTo(last.id, anchor: .bottom) }
        }
    }
}

#Preview {
    MainChatView()
}
