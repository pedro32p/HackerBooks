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
    let title : String?
    let authors : [String]? //[String]?
    let tags : [Tag]?    //[Tag]?
    let photo: UIImage
    let urlPdf : URL
    var isFavorite : Bool
    
    //MARK: - Initializations
    init(title: String?,authors: [String]?,tags: [Tag]?,photo: UIImage,urlPdf: URL) {
        
        self.title = title
        self.authors = authors
        self.tags = [Tag]
        self.photo = photo
        self.urlPdf = urlPdf
        self.isFavorite = false
    }

    //MARK: - Proxies
    func proxyForEquality() -> String {
        return "\(title)\(authors)\(tags)\(photo.hashValue)\(urlPdf)"
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
