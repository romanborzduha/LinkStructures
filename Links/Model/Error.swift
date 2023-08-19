//
//  Error.swift
//  Links
//
//  Created by Roman Borzdukha on 19.08.2023.
//

import Foundation

enum GlobalError: Error {
    case noRootFolder
}

enum APIError: Error {
    case noUrl
}
