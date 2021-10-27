//
//  Final.swift
//  movies
//
//  Created by Kunjeti Jassvanthh on 10/09/21.
//

import Foundation

struct Final : Codable
{
    var favourites: [Movie]
    var movie_list: [Movie]
    
    init(){
    favourites = []
    movie_list = []
    }
}
