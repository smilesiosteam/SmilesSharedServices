//
//  TopBrandsViewModel.swift
//  House
//
//  Created by Hanan Ahmed on 10/31/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import Foundation
import Combine
import NetworkingLayer

public class TopBrandsViewModel: NSObject {
    
    // MARK: - INPUT. View event methods
    public enum Input {
        case getTopBrands(categoryID: Int, menuItemType: String, baseUrl: String, isGuestUser: Bool)
    }
    
    public enum Output {
        case fetchTopBrandsDidSucceed(response: GetTopBrandsResponseModel)
        case fetchTopBrandsDidFail(error: Error)
    }
    
    // MARK: -- Variables
    private var output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
}

// MARK: - INPUT. View event methods
extension TopBrandsViewModel {
    public func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            switch event {
            case .getTopBrands(let categoryID, let menuItemType, let baseUrl, let isGuestUser):
                self?.getAllTopBrands(for: categoryID, menuItemType: menuItemType, baseUrl: baseUrl, isGuestUser: isGuestUser)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // Get All Top Brands
    public func getAllTopBrands(for categoryID: Int, menuItemType: String, baseUrl: String, isGuestUser: Bool) {
        let getTopBrandsRequest = GetTopBrandsRequestModel(
            categoryId: categoryID,
            menuItemType: menuItemType,
            isGuestUser: isGuestUser
        )
        
        let service = GetTopBrandsRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60),
            baseUrl: baseUrl
        )
        
        service.getTopBrandsService(request: getTopBrandsRequest)
            .sink { [weak self] completion in
                debugPrint(completion)
                switch completion {
                case .failure(let error):
                    self?.output.send(.fetchTopBrandsDidFail(error: error))
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { [weak self] response in
                debugPrint("got my response here \(response)")
                self?.output.send(.fetchTopBrandsDidSucceed(response: response))
            }
        .store(in: &cancellables)
    }
}
