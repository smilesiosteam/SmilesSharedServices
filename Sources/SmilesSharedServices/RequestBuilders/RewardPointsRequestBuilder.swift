//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 04/07/2023.
//


import Foundation
import NetworkingLayer


// if you wish you can have multiple services like this in a project
enum RewardPointsRequestBuilder {
    
    // organise all the end points here for clarity
    case getRewardPoints(request: RewardPointsRequestModel)
    
    // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
    //specify the type of HTTP request
    var httpMethod: SmilesHTTPMethod {
        switch self {
        case .getRewardPoints:
            return .POST
        }
    }
    
    // compose the NetworkRequest
    func createRequest(baseUrl: String) -> NetworkRequest {
        var headers: [String: String] = [:]

        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["CUSTOM_HEADER"] = "pre_prod"
        
        return NetworkRequest(url: getURL(baseUrl: baseUrl), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .getRewardPoints(let request):
            return request
        }
    }
    
    // compose urls for each request
    func getURL(baseUrl: String) -> String {
        switch self {
        case .getRewardPoints:
            return baseUrl + "home/get-reward-points"
        }
    }
}

