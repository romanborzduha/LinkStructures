//
//  ViewModelFactory.swift
//  Links
//
//  Created by Roman Borzdukha on 18.08.2023.
//

import UIKit

struct ViewControllerFactory {
    
    private let provider: LinkStructuresProviderProtocol
    
    init(provider: LinkStructuresProviderProtocol) {
        self.provider = provider
    }
    
    func linkStructureViewController(router: RouterProtocol, folder: LinkStructure) -> LinkViewController {
        provider.setCurrentFolder(folder)
        
        let viewModel = LinkStructureViewModel(provider: provider, router: router)
        let controller = LinkViewController()
        controller.viewModel = viewModel
        controller.title = folder.title
        
        return controller
    }
}
