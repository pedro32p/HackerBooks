//
//  Tag.swift
//  HackerBooks
//
//  Created by Pedro Herranz Roldán on 2/2/17.
//  Copyright © 2017 Pedro Herranz Roldán. All rights reserved.
//

import Foundation

typealias Tags = Set<Tag>
typealias TagName = String

struct TagConstants{
    static let favoriteTag = "Favorite"
}

struct Tag{
    
    let name : String
    
    init(name: String) {
        self.name = name.capitalized
    }
    
    static func favoriteTag()->Tag{
        return self.init(name: TagConstants.favoriteTag)
    }
    
    func isFavorite()->Bool{
        return self.name == TagConstants.favoriteTag
    }
}


//MARK: - Hashable
extension Tag: Hashable{
    public var hashValue: Int {
        return self.name.hashValue
    }
}

//MARK: - Equatable
extension Tag : Equatable{
    static func ==(lhs: Tag, rhs: Tag) -> Bool{
        return (lhs.name == rhs.name)
    }
}

//MARK: - Comparable
extension Tag: Comparable{
    static func <(lhs: Tag, rhs: Tag) -> Bool{
        
        if lhs.isFavorite(){
            return true
        }
        else if rhs.isFavorite(){
            return false
        }else{
            return lhs.name < rhs.name
        }
    }
    
}

