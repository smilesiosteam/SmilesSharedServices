//
//  File.swift
//  
//
//  Created by Habib Rehman on 13/09/2023.
//


import Foundation
import SmilesBaseMainRequestManager
import SmilesUtilities

public  class GetRestaurantListingDORequest: SmilesBaseMainRequest {

    public var filters : [RestaurantRequestFilter]?
    public var pageNo : Int?
    public var menuItemType: String?
    public var operationName : String?
    public var isGuestUser: Bool?
    
     enum CodingKeys: String, CodingKey {
        case pageNo
        case menuItemType
        case filters
        case operationName
        case isGuestUser
    }
    
    public init(filters: [RestaurantRequestFilter]? = nil, pageNo: Int? = nil, menuItemType: String? = nil, operationName: String? = nil, isGuestUser: Bool?) {
        super.init()
        self.filters = filters
        self.pageNo = pageNo
        self.menuItemType = menuItemType
        self.operationName = operationName
        self.isGuestUser = isGuestUser
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    public  override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.filters, forKey: .filters)
        try container.encodeIfPresent(self.pageNo, forKey: .pageNo)
        try container.encodeIfPresent(self.menuItemType, forKey: .menuItemType)
        try container.encodeIfPresent(self.operationName, forKey: .operationName)
        try container.encodeIfPresent(self.isGuestUser, forKey: .isGuestUser)
    }
    
}
