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

//MARK: - Decodification

//TRANSFORMAMOS EL JSONDICTIONARY EN UN OBJETO BOOK
func decode(book json: JSONDictionary) throws -> Book {
    
    //Validamos el diccionario
    /*guard let photo = json["image_url"] as? String, let urlImg = URL(string: photo), let imageData = try? Data(contentsOf: urlImg), let image = UIImage(data: imageData) else{
        //HA OCURRIDO UN ERROR
        throw BooksError.wrongURLFormatForJSONResource
    }*/
    
    guard let photo = json["image_url"] as? String, let urlImg = URL(string: photo) else {
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
    let arrayTags = Tags(transformToArray(cadenaAtransformar: tags).map({Tag(name: $0)}))
    
    let mainBundle = Bundle.main
    
    let defaultImage = mainBundle.url(forResource: "emptyImage", withExtension: "png")!
    let defaultPdf = mainBundle.url(forResource: "emptyPDF", withExtension: "pdf")!
    
    // AsyncData
    let image = AsyncData(url: urlImg, defaultData: try! Data(contentsOf: defaultImage))
    let pdf = AsyncData(url: urlPDF, defaultData: try! Data(contentsOf: defaultPdf))
    
    if let title = json["title"] as? String {
        
        //Todo ha salido bien
        //Creo el Book
        return Book(title: title, authors: arrayAutores, tags: arrayTags, photo: image, pdf: pdf)
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

//Función decode que descodifica un array de Books: recibimos el array y a cada elemento le encasquetamos un decode de opcional

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
