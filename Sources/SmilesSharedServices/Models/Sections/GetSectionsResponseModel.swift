//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 04/07/2023.
//

import Foundation

public struct GetSectionsResponseModel: Codable {
    
    public var sectionDetails: [SectionDetailDO]?
    
    public func getEventName(for section: String) -> String? {
        let section = sectionDetails?.first(where: { $0.sectionIdentifier == section })
        return section?.eventName
    }
}
public struct SectionDetailDO: Codable {
    
    public var sectionId: Int?
    public var sectionIdentifier: String?
    public var categoryId: Int?
    public var title: String?
    public var iconUrl: String?
    public var backgroundColor: String?
    public var colorDirection: String?
    public var isSortAllowed: Int?
    public var isFilterAllowed: Int?
    public var subTitle: String?
    public var searchTag: String?
    public var pickupRibbonText: String?
    public var backgroundImage: String?
    public var eventName: String?
    public var tag: String?
    public var themeId: Int?
    
    public init() {}
    
}
