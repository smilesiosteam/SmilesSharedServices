//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 05/02/2024.
//

import Foundation
import Foundation
import NetworkingLayer

public class GetFAQResponse : BaseMainResponse {

       public let faqs : [GetFaq]?

        enum GetFAQCodingKeys: String, CodingKey {
                case faqs = "faqs"
        }
    
        required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: GetFAQCodingKeys.self)
                faqs = try values.decodeIfPresent([GetFaq].self, forKey: .faqs)
            try super.init(from: decoder)
        }

}


public class GetFaq : Codable {

    public  let faqImg : String?
    public  let faqSubTitle : String?
    public  let faqTitle : String?
    public  let id : Int?

        enum CodingKeys: String, CodingKey {
                case faqImg = "faq_img"
                case faqSubTitle = "faq_sub_title"
                case faqTitle = "faq_title"
                case id = "id"
        }
    
    required public init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                faqImg = try values.decodeIfPresent(String.self, forKey: .faqImg)
                faqSubTitle = try values.decodeIfPresent(String.self, forKey: .faqSubTitle)
                faqTitle = try values.decodeIfPresent(String.self, forKey: .faqTitle)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
        }

}
