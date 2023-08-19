//
//  Link.swift
//  Links
//
//  Created by Roman Borzdukha on 16.08.2023.
//

import Foundation

class LinkStructure: Decodable {
    
    enum LinkType: String, Decodable {
        case link, folder
        
        var image: String {
            switch self {
            case .link: return "link"
            case .folder:  return  "folder.fill"
            }
        }
    }
    
    var type: LinkType
    var title: String
    var url: String?
    var children: [LinkStructure]?
    
    init(type: LinkType, title: String, url: String? = nil, children: [LinkStructure]? = nil) {
        self.type = type
        self.title = title
        self.url = url
        self.children = children
    }
}
