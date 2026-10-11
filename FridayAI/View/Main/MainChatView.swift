import SwiftUI

struct MainChatView: View {
    @State var textFieldText = ""
    @State var isSendButtonVisible: Bool = false
    @State var isLoading: Bool = false
    @State var answerText = ""
    @State var errorMessage = ""
    let ai = AIService()
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.white, .blue, .cyan],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack{
                Text("Friday AI")
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .foregroundStyle(.white)
                    .padding(.top)
                ScrollView{
                    if isLoading{
                        ProgressView()
                            .tint(.white)
                            .padding(.top, 40)
                    }
                    if !answerText.isEmpty {
                        Text(.init(answerText))
                            .foregroundStyle(.black)
                            .font(.system(size: 18, weight: .bold, design: .serif))
                            .padding()
                            .background(.white)
                            .cornerRadius(20)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Text("Ваш ответ")
                            .font(.system(size: 18, weight: .bold, design: .serif))
                            .foregroundStyle(.white)
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
                                    Text("Type you question...")
                                        .foregroundStyle(.black.opacity(0.6))
                                    Spacer()
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
