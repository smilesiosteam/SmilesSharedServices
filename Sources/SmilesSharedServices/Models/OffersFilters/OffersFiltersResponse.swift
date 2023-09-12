//
//  OffersFiltersResponseModel.swift
//  House
//
//  Created by Muhammad Shayan Zahid on 19/01/2023.
//  Copyright © 2023 Ahmed samir ali. All rights reserved.
//

import Foundation

public struct OffersFiltersResponseModel: Codable {
    public let extTransactionId: String?
    public let subCategories: [SubCategories]?
    
    public struct SubCategories: Codable {
        public let subCategoryName: String?
        public let subCategoryTypes: [SubCategoryTypes]?
        public let subCategoryId: Int?
        
        public struct SubCategoryTypes: Codable {
            public let subCategoryTypeName: String?
            public let subCategoryTypeId: Int?
        }
    }
}
