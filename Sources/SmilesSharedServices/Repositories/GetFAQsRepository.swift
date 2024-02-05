//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 06/07/2023.
//

import Foundation
import Combine
import NetworkingLayer

protocol FAQsServiceable {
    func getFAQsService(request: FAQsDetailsRequest) -> AnyPublisher<FAQsDetailsResponse, NetworkError>
    func getFAQsList() -> AnyPublisher<GetFAQResponse,NetworkError>
}

class GetFAQsRepository: FAQsServiceable {
    
    private var networkRequest: Requestable
    private var baseUrl: String

    init(networkRequest: Requestable, baseUrl: String) {
        self.networkRequest = networkRequest
        self.baseUrl = baseUrl
    }
  
    func getFAQsService(request: FAQsDetailsRequest) -> AnyPublisher<FAQsDetailsResponse, NetworkingLayer.NetworkError> {
        
        let endPoint = FAQsRequestBuilder.getFaqsDetails(request: request)
        let request = endPoint.createRequest(
            baseUrl: self.baseUrl
        )
        return self.networkRequest.request(request)
        
    }
    func getFAQsList() -> AnyPublisher<GetFAQResponse,NetworkError> {
        let endPoint = FAQsRequestBuilder.getFAQsList
        let request = endPoint.createRequest(
            baseUrl: self.baseUrl
        )
        return self.networkRequest.request(request)
    }
}
