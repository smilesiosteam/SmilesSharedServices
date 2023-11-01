//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 04/07/2023.
//

import Foundation
import Combine
import NetworkingLayer

public class SectionsViewModel: NSObject {
    
    // MARK: - INPUT. View event methods
    public enum Input {
        case getSections(categoryID: Int? = nil, subCategoryId: Int? = nil, baseUrl: String, isGuestUser: Bool, type: String? = nil,explorerPackageType: ExplorerPackage? = nil, freeTicketAvailed: Bool? = nil,platinumLimitReached: Bool? = nil,themeId: Int? = nil)
    }
    
    public enum Output {
        case fetchSectionsDidSucceed(response: GetSectionsResponseModel)
        case fetchSectionsDidFail(error: Error)
    }
    
    // MARK: -- Variables
    private var output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
}

// MARK: - INPUT. View event methods
extension SectionsViewModel {
    
    public func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            switch event {
            case .getSections(let categoryID, let subcategoryId, let baseUrl, let isGuestUser, let type, let explorerPackageType, let freeTicketAvailed,let platinumLimitReached,let themeid):
                self?.getSections(for: categoryID, subCategoryId: subcategoryId, baseUrl: baseUrl, isGuestUser: isGuestUser, type: type,explorerPackageType: explorerPackageType, freeTicketAvailed:freeTicketAvailed,platinumLimitReached: platinumLimitReached,themeid:themeid)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // Get All Sections
    private func getSections(for categoryID: Int? = nil, subCategoryId: Int?, baseUrl: String, isGuestUser: Bool, type: String?,explorerPackageType: ExplorerPackage?,freeTicketAvailed:Bool? = nil,platinumLimitReached: Bool? = nil,themeid: Int? = nil) {
        let getSectionssRequest = GetSectionsRequestModel(
            categoryId: categoryID,
            subCategoryId: subCategoryId,
            isGuestUser: isGuestUser,
            type: type,
            explorerPackageType: explorerPackageType, freeTicketAvailed: freeTicketAvailed,
            platinumLimitReached: platinumLimitReached,
            themeId: themeid
        )
        
        let service = GetSectionsRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60),
            baseUrl: baseUrl
        )
        
        service.getSectionsService(request: getSectionssRequest)
            .sink { [weak self] completion in
                debugPrint(completion)
                switch completion {
                case .failure(let error):
                    self?.output.send(.fetchSectionsDidFail(error: error))
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { [weak self] response in
                debugPrint("got my response here \(response)")
                self?.output.send(.fetchSectionsDidSucceed(response: response))
            }
        .store(in: &cancellables)
    }
    
}
