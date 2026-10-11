import Foundation

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

final class AIService {
    private let apiKey = "---"
    private let model = "gemini-flash-latest"

    func fetchAI(history: [ChatMessage]) async throws -> String {
        let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/\(model):generateContent")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "X-goog-api-key")

        let contents: [[String: Any]] = history.map {
            ["role": $0.isUser ? "user" : "model",
             "parts": [["text": $0.text]]]
        }

        let body: [String: Any] = [
            "system_instruction": ["parts": [["text": AIData.systemPrompt]]],
            "contents": contents,
            "generationConfig": ["temperature": 0.8, "maxOutputTokens": 1024]
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        print("HTTP status: \(http.statusCode)")

        guard (200..<300).contains(http.statusCode) else {
            print("API error: \(String(data: data, encoding: .utf8) ?? "")")
            let text = [429, 503].contains(http.statusCode)
                ? "The AI is busy right now. Please try again in a moment."
                : "Something went wrong (HTTP \(http.statusCode))."
            throw NSError(domain: "AIService", code: http.statusCode,
                          userInfo: [NSLocalizedDescriptionKey: text])
        }

        let result = try JSONDecoder().decode(GeminiResponse.self, from: data)
        let text = result.candidates?.first?.content?.parts?.compactMap(\.text).joined() ?? ""
        guard !text.isEmpty else { throw URLError(.cannotParseResponse) }
        return text
    }
}

struct GeminiResponse: Decodable {
    let candidates: [Candidate]?
    struct Candidate: Decodable { let content: Content? }
    struct Content: Decodable { let parts: [Part]? }
    struct Part: Decodable { let text: String? }
}
