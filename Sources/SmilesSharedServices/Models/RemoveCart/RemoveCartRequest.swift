//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 15/02/2024.
//

import Foundation
import SmilesBaseMainRequestManager

public class RemoveCartRequest: SmilesBaseMainRequest {
    
    public var restaurantId: String?

    enum CodingKeys: String, CodingKey {
        case restaurantId
    }
    
    public init(restaurantId: String? = nil) {
        super.init()
        self.restaurantId = restaurantId
    }
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(restaurantId, forKey: .restaurantId)
        try super.encode(to: encoder)
    }
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        restaurantId = try values.decodeIfPresent(String.self, forKey: .restaurantId)
        try super.init(from: decoder)
    }

}
