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
import SmilesUtilities

public class TopBrandsViewModel: NSObject {
    
    // MARK: - INPUT. View event methods
    public enum Input {
        case getTopBrands(categoryID: Int?, menuItemType: String?, themeId: String? = nil)
    }
    
    public enum Output {
        case fetchTopBrandsDidSucceed(response: GetTopBrandsResponseModel)
        case fetchTopBrandsDidFail(error: NetworkError)
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
            case .getTopBrands(let categoryID, let menuItemType,let themeid):
                self?.getAllTopBrands(for: categoryID, menuItemType: menuItemType,themeid: themeid)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // Get All Top Brands
    public func getAllTopBrands(for categoryID: Int?, menuItemType: String?,themeid: String? = nil) {
        let getTopBrandsRequest = GetTopBrandsRequestModel(
            categoryId: categoryID,
            menuItemType: menuItemType,
            isGuestUser: AppCommonMethods.isGuestUser,
            themeId: themeid
        )
        
        let service = GetTopBrandsRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60),
            baseUrl: AppCommonMethods.serviceBaseUrl
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
