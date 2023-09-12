//
//  OffersFiltersRequestModel.swift
//  House
//
//  Created by Muhammad Shayan Zahid on 19/01/2023.
//  Copyright © 2023 Ahmed samir ali. All rights reserved.
//

import Foundation
import SmilesBaseMainRequestManager

public class OffersFiltersRequestModel: SmilesBaseMainRequest {
    
    // MARK: - Model Variables
    
    public var categoryId: Int?
    public var sortingType: String?
    public var isGuestUser: Bool?
    
    public init(categoryId: Int?, sortingType: String?, isGuestUser: Bool?) {
        super.init()
        self.categoryId = categoryId
        self.sortingType = sortingType
        self.isGuestUser = isGuestUser
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Model Keys
    
    enum CodingKeys: String, CodingKey {
        case categoryId
        case sortingType
        case isGuestUser
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.categoryId, forKey: .categoryId)
        try container.encodeIfPresent(self.sortingType, forKey: .sortingType)
        try container.encodeIfPresent(self.isGuestUser, forKey: .isGuestUser)
    }
}

