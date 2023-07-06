//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 04/07/2023.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesUtilities

protocol GetRewardPointsServiceable {
    func getRewardPointsService(request: RewardPointsRequestModel) -> AnyPublisher<RewardPointsResponseModel, NetworkError>
}

class GetRewardPointsRepository: GetRewardPointsServiceable {
    
    private var networkRequest: Requestable
    private var baseUrl: String

    init(networkRequest: Requestable, baseUrl: String) {
        self.networkRequest = networkRequest
        self.baseUrl = baseUrl
    }
  
    func getRewardPointsService(request: RewardPointsRequestModel) -> AnyPublisher<RewardPointsResponseModel, NetworkError> {
        let endPoint = RewardPointsRequestBuilder.getRewardPoints(request: request)
        let request = endPoint.createRequest(baseUrl: baseUrl)
        
        return self.networkRequest.request(request)
    }
}
