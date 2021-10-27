//
//  Movies_json.swift
//  movies_tableView
//
//  Created by Kunjeti Jassvanthh on 16/09/21.
//

import UIKit

class Movies_json
{
    private init(){
        
    }
    static let shared = Movies_json()
    func get_all_movies() -> [Movie]{
        var all_movies = [Movie]()
        if let filepath = Bundle.main.path(forResource: "movie", ofType: "json"){
            do{
                let contents = try Data(contentsOf: URL(fileURLWithPath: filepath))
                let data = try JSONDecoder().decode(movie_for_trailer.self, from: contents)
                all_movies = data.results
            }
            catch{
                print(error)
            }
        }
        return all_movies
    }
    func get_movies() -> ([Movie],[Movie]){
        var fav = [Movie]()
        var mov_list = [Movie]()
        
        let  url = self.getDocumentsDirectory().appendingPathComponent("IMdb.json")
        // print(url.path)
        if(FileManager().fileExists(atPath: url.path)){
            do{
                let contents = try Data(contentsOf: url)
                let data = try JSONDecoder().decode(Final.self, from: contents)
                fav = data.favourites
                mov_list = data.movie_list
            }
            catch{
                print(error)
            }
        }
        else{
            if let filepath = Bundle.main.path(forResource: "IMdb", ofType: "json"){
                do{
                    let contents = try Data(contentsOf: URL(fileURLWithPath: filepath))
                    let data = try JSONDecoder().decode(Final.self,from: contents)
                    fav = data.favourites
                    mov_list = data.movie_list
                }
                catch{
                    print(error)
                }
            }
            else
            {
                print("File loading error")
            }
        }
        return (fav,mov_list)
    }
    
    func update_movies(fav:[Movie],mov: [Movie]){
       let url = self.getDocumentsDirectory().appendingPathComponent("IMdb.json")
        do{
            var final = Final()
            final.favourites = fav
            final.movie_list = mov
            let json_data = try JSONEncoder().encode(final)
            let str = String(data: json_data, encoding: .utf8)
            //try json_data.write(to: url, options: .atomic)
            try str?.write(to: url, atomically: true, encoding: .utf8)
        }
        catch{
            print(error)
        }
        
    }
    
    func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // just send back the first one, which ought to be the only one
    return paths[0]
    }
    
    func getTopRatedMovies() -> [Movie]{
        var list = [Movie]()
        let url = self.getDocumentsDirectory().appendingPathComponent("topRatedMovie.json")
        if(FileManager().fileExists(atPath: url.path)){
            do{
                let data = try Data(contentsOf: url)
                let contents = try JSONDecoder().decode(TopRatedMovie.self, from: data)
                list = contents.results
            }
            catch{
                print(error)
            }
        }
        else{
            if let filepath = Bundle.main.path(forResource: "topRatedMovie", ofType: "json"){
                do{
                    let _data = try Data(contentsOf: URL(fileURLWithPath: filepath))
                    let _conents = try JSONDecoder().decode(TopRatedMovie.self, from: _data)
                    list = _conents.results
                }
                catch{
                    print(error)
                }
            }
        }
        return list
    }
}
