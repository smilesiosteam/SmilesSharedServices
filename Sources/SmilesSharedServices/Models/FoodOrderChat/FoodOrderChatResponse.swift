//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 05/12/2023.
//

import Foundation

public struct FoodOrderChatResponse: Codable {
    // MARK: - Properties
    public var chatbotUrl: String?
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case chatbotUrl
    }
    
    // MARK: - Lifecycle
    public init() {}
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.chatbotUrl = try container.decodeIfPresent(String.self, forKey: .chatbotUrl)
    }
}
