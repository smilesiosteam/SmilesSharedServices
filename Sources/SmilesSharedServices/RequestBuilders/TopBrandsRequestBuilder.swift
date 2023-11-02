//
//  TopBrandsRequestBuilder.swift
//  House
//
//  Created by Hanan Ahmed on 10/31/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import Foundation
import NetworkingLayer


// if you wish you can have multiple services like this in a project
public enum TopBrandsRequestBuilder {
    
    // organise all the end points here for clarity
    case getTopBrands(request: GetTopBrandsRequestModel)
    
    // gave a default timeout but can be different for each.
   public var requestTimeOut: Int {
        return 20
    }
    
    //specify the type of HTTP request
    public var httpMethod: SmilesHTTPMethod {
        switch self {
        case .getTopBrands:
            return .POST
        }
    }
    
    // compose the NetworkRequest
   public func createRequest(baseUrl: String) -> NetworkRequest {
        var headers: [String: String] = [:]

        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["CUSTOM_HEADER"] = "pre_prod"
        
        return NetworkRequest(url: getURL(baseUrl: baseUrl), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .getTopBrands(let request):
            return request
        }
    }
    
    // compose urls for each request
    func getURL(baseUrl: String) -> String {
        switch self {
        case .getTopBrands:
            return baseUrl + "home/v1/top-brands"
        }
    }
}
