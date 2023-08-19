//
//  LinkViewModel.swift
//  Links
//
//  Created by Roman Borzdukha on 17.08.2023.
//

import Combine

protocol LinkStructureModelProtocol {
    var tableViewDataSourcePublisher: PassthroughSubject<TableViewDataSource, Never> { get }
    func start()
    func sortAction()
}

class LinkStructureViewModel: LinkStructureModelProtocol {
    var tableViewDataSourcePublisher = PassthroughSubject<TableViewDataSource, Never>()
    private let provider: LinkStructuresProviderProtocol
    private weak var router: RouterProtocol?
    
    private var tableViewDataSource: TableViewDataSource?
    
    init(provider: LinkStructuresProviderProtocol, router: RouterProtocol) {
        self.provider = provider
        self.router = router
    }
    
    func start() {
        Task {
            guard let currentFolder = provider.getCurrentFolder() else {
                tableViewDataSourcePublisher.send(.empty)
                return
            }
            
            let dataSource = createTableViewDataSource(from: currentFolder)
            tableViewDataSource = dataSource
            await MainActor.run {
                self.tableViewDataSourcePublisher.send(dataSource)
            }
        }
    }
    
    func sortAction() {
        guard var tableViewDataSource = tableViewDataSource else { return }
        
        tableViewDataSource.sections[0].rows?.sort(by: {
            
            guard let firstModel = $0 as? TableViewCellModel,
                  let secondModel = $1 as? TableViewCellModel else { return false}
            
            return firstModel.title > secondModel.title
        })
        
        tableViewDataSourcePublisher.send(tableViewDataSource)
    }
    
    private func createTableViewDataSource(from currentFolder: LinkStructure) -> TableViewDataSource {
        let rows = currentFolder.children?.map { linkStructure in
            
            TableViewCellModel(title: linkStructure.title,
                               image: linkStructure.type.image,
                               accessoryType: linkStructure.type == .folder ? .disclosureIndicator : .none) { [unowned self] in
                if linkStructure.type == .link, let url = linkStructure.url {
                    router?.goToWebView(withUrl: url)
                } else if linkStructure.type == .folder {
                    router?.goToFolder(linkStructure)
                }
            }
        }
        let sections = [TableViewSection(rows: rows)]
        let dataSource = TableViewDataSource(sections: sections)
        
        return dataSource
    }
}
