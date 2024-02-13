//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 04/07/2023.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesUtilities

public class RewardPointsViewModel: NSObject {
    
    // MARK: - INPUT. View event methods
    public enum Input {
        case getRewardPoints(baseUrl: String,isRefreshRequired: Bool? = nil)
    }
    
    public enum Output {
        case fetchRewardPointsDidSucceed(response: RewardPointsResponseModel, shouldLogout: Bool?)
        case fetchRewardPointsDidFail(error: NetworkError)
    }
    
    // MARK: -- Variables
    private var output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
}

extension RewardPointsViewModel {
    
    public func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            switch event {
            case .getRewardPoints(let baseUrl,let isRefreshRequired):
                self?.getRewardPoints(baseUrl: baseUrl,isRefreshRequired: isRefreshRequired)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    private func getRewardPoints(baseUrl: String, isRefreshRequired:Bool? = nil) {
        
        let rewardPointsRequest = RewardPointsRequestModel(isIntgParamRequired: isRefreshRequired ?? false)
        
        let service = GetRewardPointsRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60),
            baseUrl: baseUrl
        )
        
        service.getRewardPointsService(request: rewardPointsRequest)
            .sink { [weak self] completion in
                debugPrint(completion)
                switch completion {
                case .failure(let error):
                    self?.output.send(.fetchRewardPointsDidFail(error: error))
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { [weak self] response in
                self?.output.send(.fetchRewardPointsDidSucceed(response: response, shouldLogout: nil))
            }
        .store(in: &cancellables)
    }
    
}

