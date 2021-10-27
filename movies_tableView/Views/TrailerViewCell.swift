//
//  TrailerViewCell.swift
//  movies_tableView
//
//  Created by Kunjeti Jassvanthh on 22/09/21.
//

import UIKit

class TrailerViewCell: UITableViewCell {

    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var movie_img: UIImageView!
    
    @IBOutlet weak var movie_name: UILabel!
    
    private var task : URLSessionDataTask?
    
    private var observation: NSKeyValueObservation?

    override func awakeFromNib() {
        super.awakeFromNib()
        loadingView.layer.cornerRadius = 6.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        movie_img.image = nil
        self.loadingView.isHidden = false
        progressBar.progress = 0.0
        self.task?.cancel()
    }
    
    func populate(movie: Movie, indexPath: IndexPath){
        movie_name.text = movie.title
        let queue = DispatchQueue.global(qos: .background)
        let workItem = DispatchWorkItem{
            self.task = URLSession.shared.dataTask(with: URL(string: movie.image.url)!){
                (data,response,error) in
                //print(data!,error!)
                if(data != nil && error == nil){
                    DispatchQueue.main.async {
                    if(self.tag == indexPath.row){
                            self.movie_img.image = UIImage(data: data!)
                        self.loadingView.isHidden = true
                        }
                    }
                }
                
            }
            self.observation = self.task!.progress.observe(\.fractionCompleted) { progress, _ in
              DispatchQueue.main.async {
                self.progressBar.progress = Float(progress.completedUnitCount)}}
            self.task?.resume()
        }
        queue.async(execute: workItem)
    }
    
    deinit {
        observation?.invalidate()
    }
}
