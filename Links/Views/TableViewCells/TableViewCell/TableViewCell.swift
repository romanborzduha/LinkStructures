//
//  TableViewCell.swift
//  Links
//
//  Created by Roman Borzdukha on 18.08.2023.
//

import UIKit

class TableViewCell: BaseTableViewCell {
    
    static let reuseIdentifier: String = "TableViewCell"
    
    override func configure(with model: TableViewCellModelProtocol) {
        guard let model = model as? TableViewCellModel else { return }
        
        var content = defaultContentConfiguration()
        content.text = model.title
        content.image = UIImage(systemName: model.image)
        
        contentConfiguration = content
        
        accessoryType = model.accessoryType
    }
}

