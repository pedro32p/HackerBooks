//
//  Book.swift
//  HackerBooks
//
//  Created by Pedro Herranz Roldán on 30/1/17.
//  Copyright © 2017 Pedro Herranz Roldán. All rights reserved.
//

import Foundation
import UIKit

class Book {
    
    //MARK: - Stored properties
    let title : String
    let authors : [String]
    var tags : Tags
    let photo: AsyncData
    let pdf : AsyncData
    var isFavorite : Bool
    
    /*var tags : Tags{
        return _tags
    }
    
    var title : String{
        return _title
    }*/
    
    //MARK: - Initializations
    init(title: String,authors: [String],tags: Tags,photo: AsyncData,pdf: AsyncData) {
        
        self.title = title
        self.authors = authors
        self.tags = tags
        self.photo = photo
        self.pdf = pdf
        self.isFavorite = false
    }
    
    
    //MARK: - Utils
    func formattedListOfAuthors() -> String{
        
        return authors.sorted().joined(separator: ", ")
        
    }
    
    func formattedListOfTags() -> String{
        return tags.sorted().map{$0.name}.joined(separator: ", ")
    }

    //MARK: - Proxies
    func proxyForEquality() -> String {
        return "\(title)\(authors)"
    }
    func proxyForComparison() -> String {
        return proxyForEquality()
    }
    
}


//MARK: - Protocols

//Extensión para comprobar si 2 libros son iguales
extension Book : Equatable {
    
    public static func ==(lhs: Book,
                          rhs: Book) -> Bool{
        
        return (lhs.proxyForEquality() == rhs.proxyForEquality())
        
    }
}

//para compararlos
extension Book : Comparable {
    
    public static func <(lhs: Book,
                         rhs: Book) -> Bool{
        
        //print(lhs.proxyForComparison())
        return (lhs.proxyForComparison() < rhs.proxyForComparison())
        
    }
}
//descripción
extension Book : CustomStringConvertible {
    
    public var description: String {
        get{
            return "<\(type(of:self)): \(title) -- \(authors)>"  //typeof devuelve el nombre de la clase
        }
    }
}
