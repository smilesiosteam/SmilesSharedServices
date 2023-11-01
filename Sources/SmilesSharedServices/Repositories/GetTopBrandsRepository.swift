//
//  GetTopBrandsRepository.swift
//  House
//
//  Created by Hanan Ahmed on 10/31/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import Foundation
import Combine
import NetworkingLayer

protocol TopBrandsServiceable {
    func getTopBrandsService(request: GetTopBrandsRequestModel) -> AnyPublisher<GetTopBrandsResponseModel, NetworkError>
}

// GetTopBrandsRepository
class GetTopBrandsRepository: TopBrandsServiceable {
   
    private var networkRequest: Requestable
    private var baseUrl: String

    init(networkRequest: Requestable, baseUrl: String) {
        self.networkRequest = networkRequest
        self.baseUrl = baseUrl
    }
  
    func getTopBrandsService(request: GetTopBrandsRequestModel) -> AnyPublisher<GetTopBrandsResponseModel, NetworkingLayer.NetworkError> {
        let endPoint = TopBrandsRequestBuilder.getTopBrands(request: request)
        let request = endPoint.createRequest(baseUrl: self.baseUrl)
        
        return self.networkRequest.request(request)
    }
    
}
