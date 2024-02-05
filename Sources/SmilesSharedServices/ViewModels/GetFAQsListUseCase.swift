//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 05/02/2024.
//

import Foundation
import NetworkingLayer
import Combine
import SmilesBaseMainRequestManager
import SmilesUtilities

public protocol GetFAQsListUseCaseProtocol {
    func getFAQsList() -> AnyPublisher<GetFAQResponse,NetworkError>
}

public  class GetFAQsListUseCase: GetFAQsListUseCaseProtocol {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    
    public init () { }
    
    public func getFAQsList() -> AnyPublisher<GetFAQResponse,NetworkError> {
        
        let service = GetFAQsRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60), baseUrl: AppCommonMethods.serviceBaseUrl
        )
        
        return Future<GetFAQResponse, NetworkError> { [weak self] promise in
            guard let self else {
                return
            }
            service.getFAQsList()
                .sink { completion in
                    if case .failure(let error) = completion {
                        promise(.failure(error))
                    }
                } receiveValue: { [weak self] response in
                    guard self != nil else {
                        return
                    }
                    promise(.success(response))
                    
                }
                .store(in: &cancellables)
        }
        .eraseToAnyPublisher()
    }
    
    
}
