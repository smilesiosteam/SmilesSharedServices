//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 18/01/2024.
//

import Foundation
import SmilesUtilities
import SmilesBaseMainRequestManager

public class CountryListRequest : SmilesBaseMainRequest   {
    
    public var firstCallFlag : Bool?
    public var lastModifiedDate : String?
    
    public enum CountryListResponseCodingKeys: String, CodingKey {
        case countryList = "firstCallFlag"
        case lastModifiedDate = "lastModifiedDate"
    }
    
    required public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CountryListResponseCodingKeys.self)
        firstCallFlag = try values.decodeIfPresent(Bool.self, forKey: .countryList)
        lastModifiedDate = try values.decodeIfPresent(String.self, forKey: .lastModifiedDate)
        try super.init(from: decoder)
        
    }
    
    public init(firstCallFlag: Bool? = true, lastModifiedDate: String? = "") {
        super.init()
        self.firstCallFlag = firstCallFlag
        self.lastModifiedDate = lastModifiedDate
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CountryListResponseCodingKeys.self)
        try container.encodeIfPresent(self.firstCallFlag, forKey: .countryList)
        try container.encodeIfPresent(self.lastModifiedDate, forKey: .lastModifiedDate)
    }
    
    public func asDictionary(dictionary :[String : Any]) -> [String : Any] {
        
        let encoder = DictionaryEncoder()
        guard  let encoded = try? encoder.encode(self) as [String:Any]  else {
            return [:]
        }
        return encoded.mergeDictionaries(dictionary:dictionary)
        
    }
    
}
