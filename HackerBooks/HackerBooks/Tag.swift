//
//  Tag.swift
//  HackerBooks
//
//  Created by Pedro Herranz Roldán on 2/2/17.
//  Copyright © 2017 Pedro Herranz Roldán. All rights reserved.
//

import Foundation

class Tag {
    
    var name : String
    
    init(nombre : String) {
        self.name = nombre
    }
    

    
    //MARK: - Proxies
    func proxyForEquality() -> String {
        return "\(name)"
    }
    func proxyForComparison() -> String {
        return proxyForEquality()
    }
}

//MARK: - Protocols
extension Tag: Equatable {
    
    public static func ==(lhs: Tag, rhs: Tag) -> Bool {
        return (lhs.proxyForEquality() == rhs.proxyForEquality())
    }
}

//para compararlos
extension Tag : Comparable {
    
    public static func <(lhs: Tag, rhs: Tag) -> Bool{
        
        return (lhs.proxyForComparison() < rhs.proxyForComparison())
        
    }
}
