//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 04/07/2023.
//

import Foundation
import Combine
import NetworkingLayer

protocol SectionsServiceable {
    func getSectionsService(request: GetSectionsRequestModel) -> AnyPublisher<GetSectionsResponseModel, NetworkError>
}

class GetSectionsRepository: SectionsServiceable {
    private var networkRequest: Requestable
    private var baseUrl: String

    init(networkRequest: Requestable, baseUrl: String) {
        self.networkRequest = networkRequest
        self.baseUrl = baseUrl
    }
  
    func getSectionsService(request: GetSectionsRequestModel) -> AnyPublisher<GetSectionsResponseModel, NetworkingLayer.NetworkError> {
        let endPoint = SectionsRequestBuilder.getSections(request: request)
        let request = endPoint.createRequest(
            baseUrl: self.baseUrl
        )
        
        return self.networkRequest.request(request)
    }
}
