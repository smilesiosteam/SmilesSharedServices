//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 06/12/2023.
//

import Foundation
import Combine
import NetworkingLayer

protocol LiveChatUrlServiceable {
    func getLiveChatUrlService(request: FoodOrderChatRequest) -> AnyPublisher<FoodOrderChatResponse, NetworkError>
}

class LiveChatUrlRepository: LiveChatUrlServiceable {
    private var networkRequest: Requestable
    private var baseUrl: String

    init(networkRequest: Requestable, baseUrl: String) {
        self.networkRequest = networkRequest
        self.baseUrl = baseUrl
    }
  
    func getLiveChatUrlService(request: FoodOrderChatRequest) -> AnyPublisher<FoodOrderChatResponse, NetworkError> {
        let endPoint = LiveChatUrlRequestBuilder.getLiveChatUrl(request: request)
        let request = endPoint.createRequest(
            baseUrl: self.baseUrl
        )
        
        return self.networkRequest.request(request)
    }
}
