//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 21/07/2023.
//

import Foundation
import NetworkingLayer

enum WishListRequestBuilder {
    
    // organise all the end points here for clarity
    case updateWishList(request: WishListRequestModel)

    // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
    //specify the type of HTTP request
    var httpMethod: SmilesHTTPMethod {
        switch self {
        case .updateWishList:
            return .POST
        }
    }
    
    // compose the NetworkRequest
    func createRequest(baseURL: String) -> NetworkRequest {
        var headers: [String: String] = [:]

        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["CUSTOM_HEADER"] = "pre_prod"
        
        return NetworkRequest(url: getURL(from: baseURL), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .updateWishList(let request):
            return request
        }
    }
    
    // compose urls for each request
    func getURL(from baseURL: String) -> String {
        
        switch self {
        case .updateWishList:
            return baseURL + "home/update-wishlist"
        }
        
    }
}
