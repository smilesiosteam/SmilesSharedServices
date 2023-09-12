//
//  OffersFiltersRequestBuilder.swift
//  House
//
//  Created by Muhammad Shayan Zahid on 19/01/2023.
//  Copyright © 2023 Ahmed samir ali. All rights reserved.
//

import Foundation
import NetworkingLayer
import StoreKit
import SwiftUI


// if you wish you can have multiple services like this in a project
enum OffersFiltersRequestBuilder {
    
    // organise all the end points here for clarity
    case getOffersFilters(request: OffersFiltersRequestModel)
    
    // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
    //specify the type of HTTP request
    var httpMethod: SmilesHTTPMethod {
        switch self {
        case .getOffersFilters:
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
        case .getOffersFilters(let request):
            return request
        }
    }
    
    // compose urls for each request
    func getURL(baseUrl: String) -> String {
       
        
        
        switch self {
        case .getOffersFilters:
            return baseUrl + "home/get-offers-filters"
        }
    }
}

