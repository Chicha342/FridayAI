import SwiftUI

struct ChatHistoryContainer: View {
    let chat: ChatsHistoryModel
    
    var body: some View {
        HStack{
            Image(systemName: "bubble.fill")
                .foregroundStyle(.white)
                .padding(15)
                .background(Color.blue)
                .cornerRadius(100)
            
            VStack(alignment: .leading){
                Text(chat.name)
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .bold, design: .serif))
                    .lineLimit(1)
                
                Text(chat.shortText)
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .medium, design: .serif))
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    ZStack{
        Color.gray
        
        ChatHistoryContainer(chat: ChatsHistoryModel(name: "Name", shortText: "Short Text"))
    }
    
}
