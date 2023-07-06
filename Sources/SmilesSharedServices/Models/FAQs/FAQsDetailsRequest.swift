//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 06/07/2023.
//

import Foundation
import SmilesUtilities
import SmilesBaseMainRequestManager

public class FAQsDetailsRequest : SmilesBaseMainRequest {
    
    public var faqId : Int?
    
    enum CodingKeys: String, CodingKey {
        case faqId = "faqId"
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        faqId = try values.decodeIfPresent(Int.self, forKey: .faqId)
    }
    
    public init(faqId: Int = 1) {
        super.init()
        self.faqId = faqId
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.faqId, forKey: .faqId)
    }
    
    public func asDictionary(dictionary :[String : Any]) -> [String : Any] {
        
        let encoder = DictionaryEncoder()
        guard  let encoded = try? encoder.encode(self) as [String:Any]  else {
            return [:]
        }
        return encoded.mergeDictionaries(dictionary:dictionary)
        
    }
    
}
