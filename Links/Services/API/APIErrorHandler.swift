//
//  APIErrorHandler.swift
//  Links
//
//  Created by Roman Borzdukha on 19.08.2023.
//

import Foundation

struct APIErrorHandler {
    static func isRequestSuccessful<T>(forType type: T.Type, response: URLResponse) -> Bool {
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }
        
        guard 0...200 ~= httpResponse.statusCode else {
            AlertService.showErrorAlert(withMessage: "API Request for \(T.self) failed with code - \(httpResponse.statusCode)")
            return false
        }
        
        return true
    }
}
