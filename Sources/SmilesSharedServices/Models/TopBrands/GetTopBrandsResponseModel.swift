//
//  GetTopBrandsResponse.swift
//  House
//
//  Created by Hanan Ahmed on 10/31/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import Foundation

struct GetTopBrandsResponseModel: Codable {
    
    let brands: [BrandDO]?
    
    struct BrandDO: Codable {
        // MARK: - Model Variables
        
        let id: String?
        let title: String?
        let iconUrl: String?
        let redirectionUrl: String?
        
    }
}
