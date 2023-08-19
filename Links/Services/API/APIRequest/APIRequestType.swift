//
//  APIRequestType.swift
//  Links
//
//  Created by Roman Borzdukha on 17.08.2023.
//

import Foundation

enum APIRequestType {
    case linkStructure
}

// MARK: - APIRequest properties

extension APIRequestType {
    
    // NEED TO REFACTOR
    var url: URL? {
        switch self {
        case .linkStructure:
            return URL(string: "https://gist.githubusercontent.com/zrxq/5dbf5fa46d0f284be198249656c432ce/raw/3b1da37e5c32515068c39a74df15103e822d22bc/bookmarks.json")
        }
    }
    
    var method: HTTPMethodRaw {
        switch self {
        case .linkStructure:
            return HTTPMethod.GET.rawValue
        }
    }
    
    var headers: [HTTPHeader] {
        return []
    }
}

// MARK: - Additional convenient types

extension APIRequestType {
    struct HTTPHeader {
        let field: String
        let value: String
    }
    
    enum HTTPMethod: HTTPMethodRaw {
        case GET, POST, DELETE, UPDATE
    }
    
    typealias HTTPMethodRaw = String
}
