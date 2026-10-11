import Foundation

struct RequestBody: Encodable {
    let model: String
    let messages: [Message]
    let temperature: Double
    let max_tokens: Int
}

struct Message: Codable {
    let role: String
    let content: String
}

struct ChatResponse: Decodable {
    let choices: [Choice]

    struct Choice: Decodable {
        let message: Message
    }
}

enum AIError: LocalizedError {
    case invalidResponse
    case emptyResponse
    case serverError(statusCode: Int, details: String)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server returned an invalid response."

        case .emptyResponse:
            return "The AI returned an empty response."

        case let .serverError(statusCode, details):
            return "API error \(statusCode): \(details)"
        }
    }
}
