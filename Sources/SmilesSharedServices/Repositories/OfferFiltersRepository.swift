//
//  GetOffersFiltersRepository.swift
//  House
//
//  Created by Muhammad Shayan Zahid on 19/01/2023.
//  Copyright © 2023 Ahmed samir ali. All rights reserved.
//

import Foundation
import Combine
import NetworkingLayer
//import SmilesSharedServices

protocol GetOffersFiltersServiceable {
    func getOffersFiltersService(request: OffersFiltersRequestModel) -> AnyPublisher<OffersFiltersResponseModel, NetworkError>
}

public class GetOffersFiltersRepository: GetOffersFiltersServiceable {
    
    private var networkRequest: Requestable
    private var baseUrl: String
    
  // inject this for testability
    
    
    init(networkRequest: Requestable, baseUrl: String) {
        self.networkRequest = networkRequest
        self.baseUrl = baseUrl
    }
  
    func getOffersFiltersService(request: OffersFiltersRequestModel) -> AnyPublisher<OffersFiltersResponseModel, NetworkError> {
        let endPoint = OffersFiltersRequestBuilder.getOffersFilters(request: request)
        let request = endPoint.createRequest(baseUrl: self.baseUrl)
        
        return self.networkRequest.request(request)
    }
}

