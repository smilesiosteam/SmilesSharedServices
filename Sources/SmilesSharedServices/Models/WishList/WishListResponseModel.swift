//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 21/07/2023.
//

import Foundation

public struct WishListResponseModel : Codable {
    
    public let extTransactionId: String?
    public let updateWishlistStatus : Bool?
    public let responseMessage : String?
    public let responseCode: String?
    
}
