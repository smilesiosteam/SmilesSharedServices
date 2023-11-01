//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 04/07/2023.
//

import Foundation
import SmilesBaseMainRequestManager

public class GetSectionsRequestModel: SmilesBaseMainRequest {
    
    // MARK: - Model Variables
    
    public var categoryId: Int?
    public var subCategoryId: Int?
    public var isGuestUser: Bool?
    public var type: String?
    public var explorerPackageType: ExplorerPackage?
    public var freeTicketAvailed: Bool?
    public var platinumLimitReached: Bool?
    public var themeId: Int?
    
    public init(categoryId: Int?, subCategoryId: Int? = nil, isGuestUser: Bool?, type: String? = nil, explorerPackageType: ExplorerPackage? = nil,freeTicketAvailed:Bool? = nil,platinumLimitReached: Bool? = nil,themeId: Int? = nil) {
        super.init()
        self.categoryId = categoryId
        self.subCategoryId = subCategoryId
        self.isGuestUser = isGuestUser
        self.type = type
        self.explorerPackageType = explorerPackageType
        self.freeTicketAvailed = freeTicketAvailed
        self.platinumLimitReached = platinumLimitReached
        self.themeId = themeId
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Model Keys
    
    enum CodingKeys: CodingKey {
        case categoryId
        case subCategoryId
        case isGuestUser
        case type
        case explorerPackageType
        case freeTicketAvailed
        case platinumLimitReached
        case themeId
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.categoryId, forKey: .categoryId)
        try container.encodeIfPresent(self.subCategoryId, forKey: .subCategoryId)
        try container.encodeIfPresent(self.isGuestUser, forKey: .isGuestUser)
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.explorerPackageType, forKey: .explorerPackageType)
        try container.encodeIfPresent(self.freeTicketAvailed, forKey: .freeTicketAvailed)
        try container.encodeIfPresent(self.platinumLimitReached, forKey: .platinumLimitReached)
        try container.encodeIfPresent(self.themeId, forKey: .themeId)
    }
}
