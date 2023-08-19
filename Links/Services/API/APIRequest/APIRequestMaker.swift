//
//  APIRequest.swift
//  Links
//
//  Created by Roman Borzdukha on 16.08.2023.
//

import Foundation

final class APIRequestMaker {
    
    private init() {}
    
    static func makeRequest(withType type: APIRequestType) throws -> URLRequest? {
        
        guard let url = type.url else {
            throw APIError.noUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.method
        type.headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.field) }
        
        return request
    }
}
