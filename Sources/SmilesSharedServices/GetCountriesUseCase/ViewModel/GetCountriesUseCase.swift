//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 18/01/2024.
//


import Foundation
import NetworkingLayer
import Combine
import SmilesBaseMainRequestManager
import SmilesUtilities

public protocol GetCountriesUseCaseProtocol {
    func getCountriesList(lastModifiedDate: String ,firstCall: Bool) -> AnyPublisher<CountryListResponse,NetworkError>
}

public  class GetCountriesUseCase: GetCountriesUseCaseProtocol {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    
    public init () { }
    
    public func getCountriesList(lastModifiedDate: String ,firstCall: Bool) -> AnyPublisher<CountryListResponse, NetworkError> {
        
        let request = CountryListRequest()
        request.firstCallFlag = firstCall
        request.lastModifiedDate = lastModifiedDate
        
        let service = GetCountriesRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60)
        )
        
        return Future<CountryListResponse, NetworkError> { [weak self] promise in
            guard let self else {
                return
            }
            service.getCountriesListRequest(request: request)
                .sink { completion in
                    if case .failure(let error) = completion {
                        promise(.failure(error))
                    }
                } receiveValue: { [weak self] response in
                    guard let self else {
                        return
                    }
                    promise(.success(response))
                    
                }
                .store(in: &cancellables)
        }
        .eraseToAnyPublisher()
    }
    
    
}
