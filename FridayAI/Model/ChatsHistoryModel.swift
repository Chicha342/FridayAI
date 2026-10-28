import Foundation

struct ChatsHistoryModel: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let shortText: String
}
