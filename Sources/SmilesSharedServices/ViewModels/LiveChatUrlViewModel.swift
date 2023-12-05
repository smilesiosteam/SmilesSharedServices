//
//  File.swift
//
//
//  Created by Muhammad Shayan Zahid on 06/12/2023.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesUtilities

public class LiveChatUrlViewModel: NSObject {
    
    // MARK: - INPUT. View event methods
    public enum Input {
        case getLiveChatUrl(orderId: String?, chatbotType: String?, orderNumber: String?)
    }
    
    public enum Output {
        case getLiveChatUrlDidSucceed(response: FoodOrderChatResponse)
        case getLiveChatUrlDidFail(error: NetworkError)
    }
    
    // MARK: -- Variables
    private var output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
}

// MARK: - INPUT. View event methods
extension LiveChatUrlViewModel {
    public func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            switch event {
            case .getLiveChatUrl(let orderId, let chatbotType, let orderNumber):
                self?.getLiveChatUrl(for: orderId, chatbotType: chatbotType, orderNumber: orderNumber)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // Get Live Chat Url
    public func getLiveChatUrl(for orderId: String?, chatbotType: String?, orderNumber: String?) {
        let request = FoodOrderChatRequest(
            orderId: orderId,
            chatbotType: chatbotType,
            orderNumber: orderNumber
        )
        
        let service = LiveChatUrlRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60),
            baseUrl: AppCommonMethods.serviceBaseUrl
        )
        
        service.getLiveChatUrlService(request: request)
            .sink { [weak self] completion in
                debugPrint(completion)
                switch completion {
                case .failure(let error):
                    self?.output.send(.getLiveChatUrlDidFail(error: error))
                default:
                    break
                }
            } receiveValue: { [weak self] response in
                debugPrint("got my response here \(response)")
                self?.output.send(.getLiveChatUrlDidSucceed(response: response))
            }
            .store(in: &cancellables)
    }
}

