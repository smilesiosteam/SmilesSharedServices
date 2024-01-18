//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 18/01/2024.
//

import Foundation
import NetworkingLayer
import SmilesUtilities
import SmilesBaseMainRequestManager

enum GetCountriesRequestBuilder {
    
    case getCountriesRequest(request: SmilesBaseMainRequest)
    
    var requestTimeOut: Int {
        return 20
    }
    
    var httpMethod: SmilesHTTPMethod {
        switch self {
        case .getCountriesRequest:
            return .POST
        }
    }
    
    // compose the NetworkRequest
    func createRequest(endPoint: GetCountriesEndPoints) -> NetworkRequest {
        var headers: [String: String] = [:]

        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["CUSTOM_HEADER"] = "pre_prod"
        
        return NetworkRequest(url: getURL(for: endPoint), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    var requestBody: Encodable? {
        switch self {
        case .getCountriesRequest(let request):
            return request
        }
        
    }
    
    func getURL(for endPoint: GetCountriesEndPoints) -> String {
        return AppCommonMethods.serviceBaseUrl + endPoint.serviceEndPoints
    }
}

