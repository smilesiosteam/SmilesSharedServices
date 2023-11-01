//
//  GetTopBrandsRequest.swift
//  House
//
//  Created by Hanan Ahmed on 10/31/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import Foundation
import SmilesBaseMainRequestManager

public class GetTopBrandsRequestModel: SmilesBaseMainRequest {
    
    // MARK: - Model Variables
    
    public var categoryId: Int?
    public var isGuestUser: Bool?
    public var menuItemType: String?
        
    public init(categoryId: Int?, menuItemType: String?, isGuestUser: Bool?) {
        super.init()
        self.categoryId = categoryId
        self.menuItemType = menuItemType
        self.isGuestUser = isGuestUser
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Model Keys
    
    enum CodingKeys: CodingKey {
        case categoryId
        case isGuestUser
        case menuItemType
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.categoryId, forKey: .categoryId)
        try container.encodeIfPresent(self.isGuestUser, forKey: .isGuestUser)
        try container.encodeIfPresent(self.menuItemType, forKey: .menuItemType)
    }
}
