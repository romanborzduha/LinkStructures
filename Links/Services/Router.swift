//
//  Router.swift
//  Links
//
//  Created by Roman Borzdukha on 18.08.2023.
//

import UIKit
import SafariServices

protocol RouterProtocol: AnyObject {
    var navigationController: UINavigationController { get }
    
    func goToFolder(_ folder: LinkStructure)
    func goToWebView(withUrl url: String)
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController
    private let viewControllerFactory: ViewControllerFactory
    
    init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = factory
    }
    
    func goToFolder(_ folder: LinkStructure) {
        let viewController = viewControllerFactory.linkStructureViewController(router: self, folder: folder)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToWebView(withUrl url: String) {
        guard let url = URL(string: url) else { return }
        
        let safariVC = SFSafariViewController(url: url)
        navigationController.present(safariVC, animated: true)
    }
}
