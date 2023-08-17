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
    public var isGuestUser: Bool?
    public var type: String?
    
    public init(categoryId: Int?, isGuestUser: Bool?, type: String? = nil) {
        super.init()
        self.categoryId = categoryId
        self.isGuestUser = isGuestUser
        self.type = type
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Model Keys
    
    enum CodingKeys: CodingKey {
        case categoryId
        case isGuestUser
        case type
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.categoryId, forKey: .categoryId)
        try container.encodeIfPresent(self.isGuestUser, forKey: .isGuestUser)
        try container.encodeIfPresent(self.type, forKey: .type)
    }
}
