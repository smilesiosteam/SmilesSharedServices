//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 04/07/2023.
//

import Foundation
import SmilesBaseMainRequestManager

public class RewardPointsRequestModel: SmilesBaseMainRequest {
    
    // MARK: - Model Variables
    public var isIntgParamRequired: Bool?
    
    public init(isIntgParamRequired: Bool?) {
        super.init()
        self.isIntgParamRequired = isIntgParamRequired
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Model Keys
    
    enum CodingKeys: CodingKey {
        case isIntgParamRequired
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.isIntgParamRequired, forKey: .isIntgParamRequired)
    }
}
