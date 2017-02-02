//
//  Library.swift
//  HackerBooks
//
//  Created by Pedro Herranz Roldán on 30/1/17.
//  Copyright © 2017 Pedro Herranz Roldán. All rights reserved.
//

import Foundation
import UIKit

class Library {
    
    //MARK: Utility types
    typealias BooksArray = [Book]
    fileprivate typealias BooksDictionay = [String : BooksArray]
    
    //MARK: - Properties
    fileprivate var dict : BooksDictionay = BooksDictionay()
    
    var objetosTag = [Tag]()
    
    //Array de tags
    var tags = [String]()
    
    init(books boks: BooksArray) {
        
        for book in boks {
            
            if let hayTags = book.tags {
                
            }
            
        }
        
    }
    
    
    //var tagsArray = Set<String>()
    
    
    
    
            /*if let hayTags = book.tags {
                for tag in 0...hayTags.count - 1 {
                    tags.append(book.tags![tag])
                }
            }*/
            
            
            /*Meto los tags en un Set para usalos como clave
            if let tags = book.tags {
                for tag in 0...(tags.count) - 1 {
                    tagsArray.insert((tags[tag]))
                }
            }*/
            
        //}
        
        //A cada tag le asigno un Array de libros vacío
        //dict = makeEmptyAffiliations()
        
        /*Nos pateamos el BooksArray que hemos recibido y asignamos según el tag
        for each in boks {
            //a cada tag le añadimos los libros que pertenecen a él
            for tag in 0...(each.tags?.count)! - 1 {
                dict[(each.tags?[tag])!]?.append(each)
            }
        }*/
    }
    
    
    
    
    //MARK: - Utils
    
    fileprivate func makeArrayOfTags(lib libros: BooksArray) -> Array<String> {
        
        //let boks = BooksArray()
        
        for book in libros {
            
            if let hayTags = book.tags {
                for tag in 0...hayTags.count - 1 {
                    tags.append(book.tags![tag])
                }
            }
        }
        return tags.sorted()
    }
    
    
    /*fileprivate func makeEmptyAffiliations() -> BooksDictionay {
        
        var d = BooksDictionay()
        
        for tag in tagsArray.sorted(){
            d[tag] = BooksArray()
        }
        return d
    }*/
}



