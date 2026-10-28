import SwiftUI

struct LeftMenu: View {
    @Binding var isOpenChat: Bool
    var actionNewChat: () -> Void
    
    var chatsArray: [ChatsHistoryModel] = [
        ChatsHistoryModel(name: "Friday", shortText: "Talk About Friday"),
        ChatsHistoryModel(name: "Sport", shortText: "types of sport"),
        ChatsHistoryModel(name: "Chill", shortText: "chill types"),
        ChatsHistoryModel(name: "Fishing", shortText: "fish in the rivers"),
        ChatsHistoryModel(name: "Friday", shortText: "Talk About Friday"),
        ChatsHistoryModel(name: "Sport", shortText: "types of sport"),
        ChatsHistoryModel(name: "Chill", shortText: "chill types"),
        ChatsHistoryModel(name: "Fishing", shortText: "fish in the rivers")
    ]
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .blue, .purple],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(alignment: .leading){
                Button {
                    withAnimation {
                        isOpenChat = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .bold))
                        .padding(15)
                        .background(.white)
                        .cornerRadius(100)
                }
                
                Button(action: {
                    print("new chat")
                    actionNewChat()
                }, label: {
                    HStack{
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(.black)
                        
                        Text("New Chat")
                            .foregroundStyle(.black)
                            .font(.system(size: 14, weight: .semibold, design: .serif))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                })
                .padding(.vertical, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading){
                        ForEach(chatsArray) { array in
                            ChatHistoryContainer(chat: array)
                                .onTapGesture {
                                    //Action select chat
                                    print("selected chat: \(array.id)")
                                    withAnimation {
                                        isOpenChat = false
                                    }
                                }
                            
                            RoundedRectangle(cornerRadius: 100)
                                .foregroundStyle(.black.opacity(0.4))
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .padding(.horizontal, 10)
                        }
                    }
                }
            }
            .padding(.top, 50)
            .padding(.leading, 10)
        }
        .frame(width: 220)
        .cornerRadius(50)
        .ignoresSafeArea()
    }
}
