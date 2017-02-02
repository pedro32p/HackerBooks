//
//  JSONProcessing.swift
//  HackerBooks
//
//  Created by Pedro Herranz Roldán on 31/1/17.
//  Copyright © 2017 Pedro Herranz Roldán. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Alias
typealias JSONObject = AnyObject
typealias JSONDictionary  = [String : JSONObject]
typealias JSONArray = [JSONDictionary]

/*
 {
 "authors": "Scott Chacon, Ben Straub",
 "image_url": "http://hackershelf.com/media/cache/b4/24/b42409de128aa7f1c9abbbfa549914de.jpg",
 "pdf_url": "https://progit2.s3.amazonaws.com/en/2015-03-06-439c2/progit-en.376.pdf",
 "tags": "version control, git",
 "title": "Pro Git"
 }
 */

//MARK: - Decodification

//TRANSFORMAMOS EL JSONDICTIONARY EN UN OBJETO BOOK
func decode(book json: JSONDictionary) throws -> Book {
    
    //Validamos el diccionario
    guard let photo = json["image_url"] as? String, let urlImg = URL(string: photo), let imageData = try? Data(contentsOf: urlImg), let image = UIImage(data: imageData) else{
        //HA OCURRIDO UN ERROR
        throw BooksError.wrongURLFormatForJSONResource
    }
    guard let urlPdf = json["pdf_url"] as? String, let urlPDF = URL(string: urlPdf) else{
        //HA OCURRIDO UN ERROR
        throw BooksError.wrongURLFormatForJSONResource
    }
    
    guard let authors = json["authors"] as? String else {
        throw BooksError.nilJSONObject
    }
    guard let tags = json["tags"] as? String else {
        throw BooksError.nilJSONObject
    }
    
    let arrayAutores = transformToArray(cadenaAtransformar: authors)
    let arrayTags = transformToArray(cadenaAtransformar: tags)
    
    if let title = json["title"] as? String {
        
        //Todo ha salido bien
        //Creo el Book
        return Book(title: title, authors: arrayAutores, tags: arrayTags, photo: image, urlPdf: urlPDF)
    }
    else{
        throw BooksError.nilJSONObject
    }
}

//Versión opcional
func decode(book json: JSONDictionary?) throws -> Book {
    
    guard let json = json else {
        throw BooksError.nilJSONObject
    }
    return try decode(book: json)
    
}

//Función decode que descodifica un array de StarWarsCharacter: recibimos el array y a cada elemento le encasquetamos un decode de opcional

func decode (bookArray json: [JSONDictionary]) throws -> [Book] {
    
    return json.flatMap({try! decode(book: $0)})
    
}


//MARK: - Utils
//función que transforma una cadena formada por elementos separados por comas en un Array, también quita los espacios en blanco
func transformToArray(cadenaAtransformar: String) -> [String]{
    let arrayConEspacios = cadenaAtransformar.components(separatedBy: ",")
    let arraySinEspacios = arrayConEspacios.map({$0.trimmingCharacters(in: .whitespaces)})
    return arraySinEspacios
}

/* 
 {
 "authors": "Scott Chacon, Ben Straub",
 "image_url": "http://hackershelf.com/media/cache/b4/24/b42409de128aa7f1c9abbbfa549914de.jpg",
 "pdf_url": "https://progit2.s3.amazonaws.com/en/2015-03-06-439c2/progit-en.376.pdf",
 "tags": "version control, git",
 "title": "Pro Git"
 }
*/

//MARK: - Loading

//función que nos devuelve el fichero JSON
func loadFromUrlRemote(urlName url: String) throws -> JSONArray {
    if let url = URL(string: url),
        let jsonData = try? Data(contentsOf: url as URL),
        let maybeArray = try? JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray,
        let library = maybeArray{
        
        for libro in library{
            
            // extraer a todo quisqui
            if let title = libro["title"] as? String,
                let authors = libro["authors"] as? String,
                let tags = libro["tags"] as? String,
                let pdfURL = libro["pdf_url"] as? String,
                let imageURL = libro["image_url"] as? String{
                
                print((title, authors, tags, pdfURL, imageURL))
            }
        }
        return library
    }
    else{
        throw BooksError.jsonParsingError
    }
}
