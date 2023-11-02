//
//  GetCollectionsRepository.swift
//  House
//
//  Created by Shahroze Zaheer on 10/31/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import Foundation
import Combine
import NetworkingLayer

protocol CollectionsServiceable {
    func getCollectionsService(request: GetCollectionsRequestModel) -> AnyPublisher<GetCollectionsResponseModel, NetworkError>
}

// GetCollectionsRepository
class GetCollectionsRepository: CollectionsServiceable {
    
    private var networkRequest: Requestable
    private var baseUrl: String

    init(networkRequest: Requestable, baseUrl: String) {
        self.networkRequest = networkRequest
        self.baseUrl = baseUrl
    }
  
    func getCollectionsService(request: GetCollectionsRequestModel) -> AnyPublisher<GetCollectionsResponseModel, NetworkingLayer.NetworkError> {
        let endPoint = CollectionsRequestBuilder.getCollections(request: request)
        let request = endPoint.createRequest(baseUrl: self.baseUrl)
        
        return self.networkRequest.request(request)
    }
}
