//
//  openAICall.swift
//
//  Created by 加藤小夏 on 2024/09/16.
//

import Foundation
import SwiftUI
import OpenAI

extension MaruViewController {
    func fetchOpenAIResponse(str: String) async -> String{
        print("OpneAIのAPIが呼ばれました。")
        print("入力文字列: \(str)")
        let openAI = OpenAI(apiToken: "")
        
        guard let message = ChatQuery.ChatCompletionMessageParam(role: .user, content: str+"50文字以内で返して")
        else {
            print("メッセージ作成に失敗しました")
            return "メッセージ作成に失敗しました"
        }

        let query = ChatQuery(messages: [message], model: .gpt4, maxTokens: 50)

        do {
            let result = try await openAI.chats(query: query)
            print(result)
            if let content = result.choices.first?.message.content {
                print("返答内容:\n\(content)")
            }
            if let firstChoice = result.choices.first {
                switch firstChoice.message {
                case .assistant(let assistantMessage):
                    return assistantMessage.content ?? "No response"
                                    default:
                                        return "予期しない応答形式です"
                }
            } else {
                return "結果に選択肢が含まれていません"
                          }
                      } catch {
                          return "エラー: \(error.localizedDescription)"
                      }
                  }
        
    
    // fetchOpenAIResponseを使用する関数
//       func openAIResponse() async {
//           let response = await fetchOpenAIResponse() // fetchOpenAIResponseを呼び出し
//           print("OpenAI Response: \(response)")
//       }

    }

