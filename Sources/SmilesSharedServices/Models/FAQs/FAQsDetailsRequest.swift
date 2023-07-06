//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 06/07/2023.
//

import Foundation
import SmilesUtilities

public class FAQsDetailsRequest : Codable {
    
    public var faqId : Int?
    
    enum CodingKeys: String, CodingKey {
        case faqId = "faqId"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        faqId = try values.decodeIfPresent(Int.self, forKey: .faqId)
    }
    
    public init(faqId: Int = 1) {
        self.faqId = faqId
    }
    
    public func asDictionary(dictionary :[String : Any]) -> [String : Any] {
        
        let encoder = DictionaryEncoder()
        guard  let encoded = try? encoder.encode(self) as [String:Any]  else {
            return [:]
        }
        return encoded.mergeDictionaries(dictionary:dictionary)
        
    }
    
}
