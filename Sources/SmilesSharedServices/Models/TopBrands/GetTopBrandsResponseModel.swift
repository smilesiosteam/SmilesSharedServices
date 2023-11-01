//
//  GetTopBrandsResponse.swift
//  House
//
//  Created by Hanan Ahmed on 10/31/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import Foundation

public struct GetTopBrandsResponseModel: Codable {
    
    public let brands: [BrandDO]?
    
    public struct BrandDO: Codable {
        // MARK: - Model Variables
        
        public let id: String?
        public let title: String?
        public let iconUrl: String?
        public let redirectionUrl: String?
        
    }
}
