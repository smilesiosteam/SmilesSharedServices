//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 21/07/2023.
//

import Foundation
import Combine
import NetworkingLayer

protocol WishListServiceable {
    func updateWishList(request: WishListRequestModel) -> AnyPublisher<WishListResponseModel, NetworkError>
}

class WishListRepository: WishListServiceable {
    
    private var networkRequest: Requestable
    private var baseURL: String

    init(networkRequest: Requestable, baseURL: String) {
        self.networkRequest = networkRequest
        self.baseURL = baseURL
    }
    
    func updateWishList(request: WishListRequestModel) -> AnyPublisher<WishListResponseModel, NetworkError> {
        let endPoint = WishListRequestBuilder.updateWishList(request: request)
        let request = endPoint.createRequest(
            baseURL: baseURL
        )
        
        return self.networkRequest.request(request)
    }
}
