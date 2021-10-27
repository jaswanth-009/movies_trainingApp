//
//  MovieCell.swift
//  movies
//
//  Created by Kunjeti Jassvanthh on 10/09/21.
//

import UIKit

protocol MyDelegate {
    func didClick(button_state: UIButton , cell_no: Int)
}

class MovieCell: UITableViewCell {

    var delegate_obj: MyDelegate?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var movie_image: UIImageView!
    
    @IBOutlet weak var movie_name: UILabel!
    
    @IBOutlet weak var movie_year: UILabel!
    
    @IBOutlet weak var fav_button: UIButton!
    
    private var task: URLSessionDataTask?

    @IBAction func onClick(_ sender: UIButton)
    {
        delegate_obj?.didClick(button_state : sender,cell_no: tag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadingView.layer.cornerRadius = 6.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movie_image.image = nil
        movie_name.text = ""
        movie_year.text = ""
        fav_button.tintColor = nil
        self.task?.cancel()
    }
    
    private func showSpinner(){
        activityIndicator.startAnimating()
    }
    
    private func hideSpinner(){
        activityIndicator.stopAnimating()
    }
    
    func setup_cell(index_Path: IndexPath, movie: Movie){
       
        self.showSpinner()
        
        if(index_Path.section == 0)
        {
            fav_button.tintColor = UIColor.red
        }
        else
        {
            fav_button.tintColor = UIColor.blue
        }
        
        movie_name.text = movie.title
        movie_year.text = String(movie.year)
        
        let queue  = DispatchQueue.global(qos: .userInteractive)
        let workItem = DispatchWorkItem{
            self.task =  URLSession.shared.dataTask(with: URL(string: movie.image.url)!) {
                (data,response,error) in
                if data != nil && error == nil{
                    DispatchQueue.main.sync {
                        if(self.tag == index_Path.row){
                            self.movie_image.contentMode = .scaleToFill
                            self.movie_image.image = UIImage(data: data!)
                            self.hideSpinner()
                        }
                    }
                }
            }
            self.task!.resume()
        }
        queue.async(execute: workItem)
    }
}
