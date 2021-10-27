//
//  TopRatedMovieCell.swift
//  movies_tableView
//
//  Created by Kunjeti Jassvanthh on 19/09/21.
//

import UIKit
protocol Add_to_Watchlist {
    func add_movie(mov_name: String)
}
class TopRatedMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movie_img: UIImageView!
    
    @IBOutlet weak var movie_year: UILabel!
    
    @IBOutlet weak var movie_name: UILabel!
    
    private var task: URLSessionDataTask?
    
    var delegate_watchlist : Add_to_Watchlist?
    
    
    @IBAction func save_to_watchlist(_ sender: UIButton) {
        sender.setTitleColor(UIColor.red, for: .normal)
        delegate_watchlist?.add_movie(mov_name: movie_name.text!)
    }
    
    override func prepareForReuse() {
        movie_img.image = nil
        movie_year.text = ""
        movie_name.text = ""
    }
    func populate(movie: Movie, indexPath: IndexPath){
        self.movie_name.text = movie.title
        self.movie_year.text = String(movie.year)
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        let workItem = DispatchWorkItem{
            self.task = URLSession.shared.dataTask(with: URL(string: movie.image.url)!){
                (data,response,error) in
                if(data != nil && error == nil){
                    DispatchQueue.main.async {
                        if(self.tag == indexPath.row){
                            self.movie_img.contentMode = .scaleToFill
                            self.movie_img.image = UIImage(data: data!)
                        }
                    }
                }
            }
            self.task?.resume()
        }
        queue.async(execute: workItem)
    }
    
}
