//
//  File.swift
//  
//
//  Created by Hanan Ahmed on 11/16/23.
//

import Foundation

public struct EligibleSubscriptionModel: Codable {
    public let subscriptionTitle: String?
    public let freeTrialDays: Int?
    public let cost : Int?
    
    enum CodingKeys: String, CodingKey {
        case subscriptionTitle
        case freeTrialDays
        case cost
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        subscriptionTitle = try values.decodeIfPresent(String.self, forKey: .subscriptionTitle)
        freeTrialDays = try values.decodeIfPresent(Int.self, forKey: .freeTrialDays)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
    }
}
