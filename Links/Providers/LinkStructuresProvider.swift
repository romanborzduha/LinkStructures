//
//  LinkProvider.swift
//  Links
//
//  Created by Roman Borzdukha on 17.08.2023.
//

import Foundation

protocol LinkStructuresProviderProtocol {
    func rootFolder() async -> LinkStructure?
    func getCurrentFolder() -> LinkStructure?
    func setCurrentFolder(_ folder: LinkStructure)
}

class LinkStructuresProvider: LinkStructuresProviderProtocol {
    
    private let api: APIClient
    private var currentFolder: LinkStructure?
    private var rootFolder: LinkStructure?
    
    init(api: APIClient) {
        self.api = api
    }
    
    func rootFolder() async -> LinkStructure? {
        guard let rootFolderLinkStructure = await api.linkStructure() else { return nil }
        let rootFolder = LinkStructure(type: .folder, title: rootFolderLinkStructure.title, children: [rootFolderLinkStructure])
        
        return rootFolder
    }
    
    func getCurrentFolder() -> LinkStructure? {
        return currentFolder
    }
    
    func setCurrentFolder(_ folder: LinkStructure) {
        currentFolder = folder
    }
}
