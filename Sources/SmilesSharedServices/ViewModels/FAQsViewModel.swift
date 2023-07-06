//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 06/07/2023.
//

import Foundation
import Combine
import NetworkingLayer

public class FAQsViewModel: NSObject {
    
    // MARK: - INPUT. View event methods
    public enum Input {
        case getFAQsDetails(faqId: Int, baseUrl: String)
    }
    
    public enum Output {
        case fetchFAQsDidSucceed(response: FAQsDetailsResponse)
        case fetchFAQsDidFail(error: Error)
    }
    
    // MARK: -- Variables
    private var output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
}

// MARK: - INPUT. View event methods
extension FAQsViewModel {
    
    public func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            switch event {
            case .getFAQsDetails(let faqId, let baseUrl):
                self?.getFAQsDetails(for: faqId, baseUrl: baseUrl)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    private func getFAQsDetails(for faqId: Int, baseUrl: String) {
        
        let getFAQsRequest = FAQsDetailsRequest(
            faqId: faqId
        )
        
        let service = GetFAQsRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60),
            baseUrl: baseUrl
        )
        
        service.getFAQsService(request: getFAQsRequest)
            .sink { [weak self] completion in
                debugPrint(completion)
                switch completion {
                case .failure(let error):
                    self?.output.send(.fetchFAQsDidFail(error: error))
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { [weak self] response in
                self?.output.send(.fetchFAQsDidSucceed(response: response))
            }
        .store(in: &cancellables)
    }
}
