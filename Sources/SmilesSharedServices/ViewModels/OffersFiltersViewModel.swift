//
//  OffersFiltersViewModel.swift
//  House
//
//  Created by Muhammad Shayan Zahid on 19/01/2023.
//  Copyright © 2023 Ahmed samir ali. All rights reserved.
//

import Foundation
import Combine
import NetworkingLayer


public class OffersFiltersViewModel: NSObject {
    
    // MARK: - INPUT. View event methods
    public enum Input {
        case getOffersFilters(categoryId: Int, sortingType: String?, baseUrl: String,isGuestUser: Bool)
    }
    
    public enum Output {
        case fetchOffersFiltersDidSucceed(response: OffersFiltersResponseModel)
        case fetchOffersFiltersDidFail(error: Error)
    }
    
    // MARK: -- Variables
    private var output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
}

extension OffersFiltersViewModel {
    public func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            switch event {
            case .getOffersFilters(let categoryId, let sortingType, let baseUrl , let isGuestUser):
                self?.getOffersFilters(categoryId: categoryId, sortingType: sortingType, baseUrl: baseUrl, isGuestUser: isGuestUser)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    func getOffersFilters(categoryId: Int, sortingType: String?, baseUrl: String,isGuestUser: Bool) {
        let offersFiltersRequest = OffersFiltersRequestModel(categoryId: categoryId, sortingType: sortingType, isGuestUser: isGuestUser)
        
        let service = GetOffersFiltersRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60),
            baseUrl: baseUrl
        )
        
        service.getOffersFiltersService(request: offersFiltersRequest)
            .sink { [weak self] completion in
                debugPrint(completion)
                switch completion {
                case .failure(let error):
                    self?.output.send(.fetchOffersFiltersDidFail(error: error))
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { [weak self] response in
                debugPrint("got my response here \(response)")
                self?.output.send(.fetchOffersFiltersDidSucceed(response: response))
            }
        .store(in: &cancellables)
    }
}


