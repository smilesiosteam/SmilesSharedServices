//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 21/07/2023.
//

import Foundation
import Combine
import NetworkingLayer

public class WishListViewModel: NSObject {
    
    // MARK: - INPUT. View event methods
    public enum Input {
        case updateRestaurantWishlistStatus(operation: Int, restaurantId: String, baseUrl: String)
        case updateOfferWishlistStatus(operation: Int, offerId: String, baseUrl: String)
    }
    
    public enum Output {
        case updateWishlistStatusDidSucceed(response: WishListResponseModel)
        case updateWishlistDidFail(error: NetworkError)
    }
    
    // MARK: -- Variables
    private var output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
}

// MARK: - INPUT. View event methods
public extension WishListViewModel {
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            guard let self else { return }
            switch event {
            case .updateRestaurantWishlistStatus(let operation, let restaurantId, let baseUrl):
                self.updateWishlistStatus(with: operation, restaurantId: restaurantId, offerId: nil, baseURL: baseUrl)
            case .updateOfferWishlistStatus(let operation, let offerId, let baseUrl):
                self.updateWishlistStatus(with: operation, restaurantId: nil, offerId: offerId, baseURL: baseUrl)
            }
        }.store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    private func updateWishlistStatus(with operation: Int, restaurantId: String?, offerId: String?, baseURL: String) {

        let updateWishListRequest = WishListRequestModel(
            restaurantId: restaurantId,
            operation: operation,
            offerId: offerId
        )
        
        let service = WishListRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60), baseURL: baseURL
        )
        
        service.updateWishList(request: updateWishListRequest)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.output.send(.updateWishlistDidFail(error: error))
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { [weak self] response in
                self?.output.send(.updateWishlistStatusDidSucceed(response: response))
            }
        .store(in: &cancellables)
        
    }
    
}
