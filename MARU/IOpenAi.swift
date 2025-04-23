import SwiftUI
import OpenAI

class IOpenAi {
    @State private var responseText: String = "Loading..."
       @State private var inputText: String = "" // 入力用のプロパティ


    @MainActor
    func fetchOpenAIResponse() async {
        let openAI = OpenAI(apiToken: "")

        guard let message = ChatQuery.ChatCompletionMessageParam(role: .user, content: inputText) else {
                   print("メッセージ作成に失敗しました")
                   return
               }

               let query = ChatQuery(messages: [message], model: .gpt4)

               do {
                   let result = try await openAI.chats(query: query)
                   if let firstChoice = result.choices.first {
                       switch firstChoice.message {
                       case .assistant(let assistantMessage):
                           await MainActor.run {
                               responseText = assistantMessage.content ?? "No response"
                           }
                       default:
                           await MainActor.run {
                               responseText = "予期しない応答形式です"
                           }
                       }
                   } else {
                       await MainActor.run {
                           responseText = "結果に選択肢が含まれていません"
                       }
                   }
               } catch {
                   await MainActor.run {
                       responseText = "エラー: \(error.localizedDescription)"
                   }
               }
           }
       }
