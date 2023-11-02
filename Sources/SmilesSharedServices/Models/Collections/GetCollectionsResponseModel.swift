//
//  GetCollectionsResponseModel.swift
//  House
//
//  Created by Shahroze Zaheer on 10/31/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import Foundation

public struct GetCollectionsResponseModel: Codable {
    
    public let collections: [CollectionDO]?
    
   public struct CollectionDO: Codable {
        // MARK: - Model Variables
        
       public let id: String?
       public let title: String?
       public let description: String?
       public let imageUrl: String?
       public let iconUrl: String?
       public let redirectionUrl: String?
        
    }
}
