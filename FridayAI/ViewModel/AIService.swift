import Foundation

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

final class AIService {
    private let apiKey = "--"
    private let model = "gemini-flash-latest"

    func fetchAI(message: String) async throws -> String {

        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/\(model):generateContent"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        print("Request URL: \(url.absoluteString)")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        request.setValue(
            apiKey,
            forHTTPHeaderField: "X-goog-api-key"
        )

        let body: [String: Any] = [
            "system_instruction": [
                "parts": [
                    ["text": AIData.systemPrompt]
                ]
            ],
            "contents": [
                [
                    "parts": [
                        ["text": message]
                    ]
                ]
            ]
        ]

        request.httpBody = try JSONSerialization.data(
            withJSONObject: body
        )

        print("Sending request to Gemini...")

        let (data, response) = try await URLSession.shared.data(
            for: request
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("HTTP status: \(httpResponse.statusCode)")

        guard (200..<300).contains(httpResponse.statusCode) else {

            let errorBody = String(
                data: data,
                encoding: .utf8
            ) ?? "Unknown error"

            print("API error response: \(errorBody)")

            throw NSError(
                domain: "AIService",
                code: httpResponse.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Gemini API error: HTTP \(httpResponse.statusCode)"
                ]
            )
        }

        let result = try JSONDecoder().decode(
            GeminiResponse.self,
            from: data
        )

        guard let text = result.candidates?.first?
            .content.parts.first?.text else {

            print(
                "Unexpected response: " +
                (String(data: data, encoding: .utf8) ?? "")
            )

            throw URLError(.cannotParseResponse)
        }

        print("Gemini response received!")

        return text
    }
}

struct GeminiResponse: Decodable {

    let candidates: [Candidate]?

    struct Candidate: Decodable {
        let content: Content
    }

    struct Content: Decodable {
        let parts: [Part]
    }

    struct Part: Decodable {
        let text: String?
    }
}
