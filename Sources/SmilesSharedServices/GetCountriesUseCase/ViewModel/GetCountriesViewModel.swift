//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 18/01/2024.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesBaseMainRequestManager
import DeviceAppCheck
import SmilesLanguageManager
import SmilesUtilities

class GetCountriesViewModel: NSObject {
    
    // MARK: -- Variables
    private var output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    private let getCountriesUseCase: GetCountriesUseCaseProtocol
    
    // MARK: - Init
    public init(getCountriesUseCase: GetCountriesUseCaseProtocol = GetCountriesUseCase()) {
        self.getCountriesUseCase = getCountriesUseCase
    }
}


extension GetCountriesViewModel {
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            switch event {
            case .getCountriesList(let lastModifiedDate, let firstCall):
                self?.getCountries(lastModifiedDate: lastModifiedDate, firstCall: firstCall)
            
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    

    func getCountries(lastModifiedDate: String ,firstCall: Bool) {
        getCountriesUseCase.getCountriesList(lastModifiedDate: lastModifiedDate, firstCall: firstCall)
            .sink { [weak self] completion in
                if case.failure(let error) = completion {
                    self?.output.send(.fetchCountriesDidFail(error: error))
                }
            } receiveValue: { [weak self] response in
                self?.output.send(.fetchCountriesDidSucceed(response: response))
            }.store(in: &cancellables)
    }
}

extension GetCountriesViewModel {
    
    enum Input {
        case getCountriesList(lastModifiedDate: String ,firstCall: Bool)
    }
    
    enum Output {
        
        case fetchCountriesDidSucceed(response: CountryListResponse)
        case fetchCountriesDidFail(error: NetworkError)
        
    }
}
