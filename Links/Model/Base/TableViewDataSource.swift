//
//  TableViewDataSource.swift
//  Links
//
//  Created by Roman Borzdukha on 18.08.2023.
//

import UIKit

struct TableViewDataSource {
    
    var sections: [TableViewSection]
    
    var isEmpty: Bool {
        numberOfSections() == 0
    }
    
    static let empty = TableViewDataSource(sections: [])
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        sections[section].rows?.count ?? 0
    }
    
    func cellModel(atIndexPath indexPath: IndexPath) -> TableViewCellModelProtocol? {
        sections[indexPath.section].rows?[indexPath.row]
    }
}

struct TableViewSection {
    var rows: [TableViewCellModelProtocol]?
}

protocol TableViewCellModelProtocol {
    var reuseId: String { get }
    var action: (() -> ())? { get }
}

class BaseTableViewCell: UITableViewCell {
    func configure(with model: TableViewCellModelProtocol) {}
}

