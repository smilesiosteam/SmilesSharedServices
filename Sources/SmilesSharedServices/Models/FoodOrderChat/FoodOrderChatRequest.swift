//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 05/12/2023.
//

import Foundation
import SmilesBaseMainRequestManager

public class FoodOrderChatRequest: SmilesBaseMainRequest {
    // MARK: - Properties
    var orderId: String?
    var chatbotType: String?
    var orderNumber: String?
    
    // MARK: - Lifecycle
    public init(orderId: String? = nil, chatbotType: String? = nil, orderNumber: String? = nil) {
        super.init()
        self.orderId = orderId
        self.chatbotType = chatbotType
        self.orderNumber = orderNumber
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case orderId
        case orderNumber
        case chatbotType
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.orderId, forKey: .orderId)
        try container.encodeIfPresent(self.chatbotType, forKey: .chatbotType)
        try container.encodeIfPresent(self.orderNumber, forKey: .orderNumber)
    }
}
