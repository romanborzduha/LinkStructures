//
//  TableViewCellModel.swift
//  Links
//
//  Created by Roman Borzdukha on 18.08.2023.
//

import UIKit
 
class TableViewCellModel: TableViewCellModelProtocol {
    
    var reuseId: String {
        return String(describing: TableViewCell.self)
    }
    
    let title: String
    let image: String
    let accessoryType: UITableViewCell.AccessoryType
    var action: (() -> ())?
    
    init(title: String,
         image: String,
         accessoryType: UITableViewCell.AccessoryType = .none,
         action: (() -> ())? = nil) {
        self.title = title
        self.image = image
        self.accessoryType = accessoryType
        self.action = action
    }
}
