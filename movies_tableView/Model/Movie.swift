//
//  Movie.swift
//  movies
//
//  Created by Kunjeti Jassvanthh on 10/09/21.
//

import Foundation

struct Movie : Codable
{
    var id: String
    var image: Image
    var title: String
    var titleType: String
    var year: Int
}
