//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 06/12/2023.
//

import Foundation
import NetworkingLayer

// if you wish you can have multiple services like this in a project
enum LiveChatUrlRequestBuilder {
    
    // organise all the end points here for clarity
    case getLiveChatUrl(request: FoodOrderChatRequest)
    
    // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
    //specify the type of HTTP request
    var httpMethod: SmilesHTTPMethod {
        switch self {
        case .getLiveChatUrl:
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
        case .getLiveChatUrl(let request):
            return request
        }
    }
    
    // compose urls for each request
    func getURL(baseUrl: String) -> String {
        switch self {
        case .getLiveChatUrl:
            return baseUrl + "chatbot/get-live-chat-details"
        }
    }
}
