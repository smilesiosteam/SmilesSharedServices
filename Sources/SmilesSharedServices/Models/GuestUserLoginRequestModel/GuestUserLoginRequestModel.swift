//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 22/01/2024.
//

import Foundation
import SmilesUtilities
import SmilesBaseMainRequestManager

public class GuestUserLoginRequestModel: SmilesBaseMainRequest {

    public var isGuestUser: Bool?

    enum CodingKeys: String, CodingKey {

        case isGuestUser
    }
    
    public init(isGuestUser: Bool? = nil) {
        super.init()
        self.isGuestUser = isGuestUser
    }
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        isGuestUser = try values.decodeIfPresent(Bool.self, forKey: .isGuestUser)
//        try super.init(from: decoder)
    }
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.isGuestUser, forKey: .isGuestUser)
    }
    

    public func asDictionary(dictionary: [String: Any]) -> [String: Any] {
        let encoder = DictionaryEncoder()
        guard let encoded = try? encoder.encode(self) as [String: Any] else {
            return [:]
        }
        return encoded.mergeDictionaries(dictionary: dictionary)
    }
}
