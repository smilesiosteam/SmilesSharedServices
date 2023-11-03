//
//  CollectionsViewModel.swift
//  House
//
//  Created by Shahroze Zaheer on 10/31/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesUtilities

public class CollectionsViewModel: NSObject {
    
    // MARK: - INPUT. View event methods
   public enum Input {
        case getCollections(categoryID: Int? = nil, menuItemType: String?, themeId: String? = nil)
    }
    
   public enum Output {
        case fetchCollectionsDidSucceed(response: GetCollectionsResponseModel)
        case fetchCollectionsDidFail(error: Error)
    }
    
    // MARK: -- Variables
    private var output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
}

// MARK: - INPUT. View event methods
extension CollectionsViewModel {
   public func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            switch event {
            case .getCollections(let categoryID, let menuItemType,let themeid):
                self?.getCollections(for: categoryID, menuItemType: menuItemType,themeId: themeid)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // Get All cuisines
   public func getCollections(for categoryID: Int? = nil, menuItemType: String?, themeId: String? = nil) {
        let getCuisinesRequest = GetCollectionsRequestModel(
            categoryId: categoryID,
            menuItemType: menuItemType,
            isGuestUser: AppCommonMethods.isGuestUser,
            themeId: themeId
        )
        
        let service = GetCollectionsRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60),
            baseUrl: AppCommonMethods.serviceBaseUrl
        )
        
        service.getCollectionsService(request: getCuisinesRequest)
            .sink { [weak self] completion in
                debugPrint(completion)
                switch completion {
                case .failure(let error):
                    self?.output.send(.fetchCollectionsDidFail(error: error))
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { [weak self] response in
                debugPrint("got my response here \(response)")
                self?.output.send(.fetchCollectionsDidSucceed(response: response))
            }
        .store(in: &cancellables)
    }
}
