//
//  Errors.swift
//  HackerBooks
//
//  Created by Pedro Herranz Roldán on 31/1/17.
//  Copyright © 2017 Pedro Herranz Roldán. All rights reserved.
//

import Foundation

enum BooksError : Error {
    case wrongURLFormatForJSONResource
    case resourcePointedByURLNotReachable
    case wrongJSONFormat
    case nilJSONObject
    case jsonParsingError
}
