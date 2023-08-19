//
//  Array.swift
//  Links
//
//  Created by Roman Borzdukha on 18.08.2023.
//

import Foundation

extension Array {
    func unwrapElements<T>() -> [T] where Element == T? {
        compactMap { $0 }
    }
}
