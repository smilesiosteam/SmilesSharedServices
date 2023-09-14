//
//  File 2.swift
//  
//
//  Created by Habib Rehman on 13/09/2023.
//

import Foundation
import SmilesUtilities


public struct GetRestaurantListingDOResponse: Codable {
    public var extTransactionID: String?
    public var restaurantBreakSize: Int?
    public var isLastPageReached: Bool?
    public  var defaultSortedName: String?
    public  var restaurants: [Restaurant]?
    public  var totalRestaurantCount: Int?
    public  var isRestaurantBreakEnabled: Bool?
    
    public  enum CodingKeys: String, CodingKey {
        case extTransactionID = "extTransactionId"
        case restaurantBreakSize, isLastPageReached, defaultSortedName, restaurants, totalRestaurantCount, isRestaurantBreakEnabled
    }
}
