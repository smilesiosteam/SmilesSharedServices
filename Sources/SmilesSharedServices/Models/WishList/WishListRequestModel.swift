//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 21/07/2023.
//

import Foundation
import SmilesBaseMainRequestManager

class WishListRequestModel : SmilesBaseMainRequest {
    
    // MARK: - Model Variables
    var restaurantId : String?
    var operation : Int?
    var offerId: String?
    
    init(restaurantId : String?, operation : Int?, offerId: String?) {
        super.init()
        self.restaurantId = restaurantId
        self.operation = operation
        self.offerId = offerId
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Model Keys
    
    enum CodingKeys: CodingKey {
        case restaurantId
        case operation
        case offerId
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.restaurantId, forKey: .restaurantId)
        try container.encodeIfPresent(self.operation, forKey: .operation)
        try container.encodeIfPresent(self.offerId, forKey: .offerId)
    }
}
