//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 18/01/2024.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesOffers
import SmilesBaseMainRequestManager

protocol GetCountriesRepositoriesServiceable {
    func getCountriesListRequest(request: CountryListRequest) -> AnyPublisher<CountryListResponse, NetworkError>
}

class GetCountriesRepository: GetCountriesRepositoriesServiceable {
    
    private var networkRequest: Requestable
    
  // inject this for testability
    init(networkRequest: Requestable) {
        self.networkRequest = networkRequest
    }

    func getCountriesListRequest(request: CountryListRequest) -> AnyPublisher<CountryListResponse, NetworkError> {
        let endPoint = GetCountriesRequestBuilder.getCountriesRequest(request: request)
        let request = endPoint.createRequest(endPoint: .getCountries)
        return self.networkRequest.request(request)
    }
    
}
