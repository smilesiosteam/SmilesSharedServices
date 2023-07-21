//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 06/07/2023.
//

import Foundation
import NetworkingLayer

public class FAQsDetailsResponse : BaseMainResponse {
    
    public let faqsDetails : [FaqsDetail]?
    
    enum FaqsDetailsCodingKeys: String, CodingKey {
        case faqsDetails = "faqsDetails"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: FaqsDetailsCodingKeys.self)
        faqsDetails = try values.decodeIfPresent([FaqsDetail].self, forKey: .faqsDetails)
        try super.init(from: decoder)
    }
    
}

public class FaqsDetail : Codable {
    
    public let faqContent : String?
    public let faqTitle : String?
    public let id : Int?
    public var isHidden: Bool?
    
    enum CodingKeys: String, CodingKey {
        case faqContent = "faq_content"
        case faqTitle = "faq_title"
        case id = "id"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        faqContent = try values.decodeIfPresent(String.self, forKey: .faqContent)
        faqTitle = try values.decodeIfPresent(String.self, forKey: .faqTitle)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }
    
}
