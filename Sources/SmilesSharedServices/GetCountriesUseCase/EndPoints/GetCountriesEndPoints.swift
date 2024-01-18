//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 18/01/2024.
//


import Foundation
import NetworkingLayer


public enum GetCountriesEndPoints: String {
    case getCountries
}

extension GetCountriesEndPoints {
    var serviceEndPoints: String {
        switch self {
        case .getCountries:
            return EndPoints.getCountryListEndpoint
        }
    }
}
