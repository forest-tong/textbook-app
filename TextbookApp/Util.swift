//
//  Util.swift
//  TextbookApp
//
//  Created by Daniel Galvez on 4/25/15.
//  Copyright (c) 2015 Forest Tong. All rights reserved.
//

import Foundation

func makeBooks() -> [Textbook] {
    let book = Textbook(className: "Textbook")
    book.edition = 1
    book.name = "SICP"
    book.condition = "pdf"
    book.price = 0
    book.notes = "Lorem ipsum"
    book.owner = PFUser.currentUser()!
    return [book, book, book]
}