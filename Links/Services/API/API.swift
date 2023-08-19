//
//  NetworkManager.swift
//  Links
//
//  Created by Roman Borzdukha on 16.08.2023.
//

import Foundation

protocol APIClient {
    func linkStructure() async -> LinkStructure?
}

struct API {
    
    private let decoder = JSONDecoder()
    
    private func makeRequest<T: Decodable>(type: APIRequestType) async -> T? {
        do {
            guard let request = try APIRequestMaker.makeRequest(withType: type) else { return nil }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard APIErrorHandler.isRequestSuccessful(forType: T.self, response: response) else {
                return nil
            }
            
            let decodedData = try decoder.decode(T.self, from: data)
            
            return decodedData
        } catch let error {
            AlertService.showErrorAlert(withMessage: "API Request for \(T.self) failed with error - \(error.localizedDescription)")
            
            return nil
        }
    }
}

// MARK: - Requests

extension API: APIClient {
    func linkStructure() async -> LinkStructure? {
        await makeRequest(type: .linkStructure)
    }
}
