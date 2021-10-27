//
//  TrailerViewController.swift
//  movies_tableView
//
//  Created by Kunjeti Jassvanthh on 21/09/21.
//

import UIKit

class TrailerViewController: UIViewController {

    @IBOutlet weak var trailerView: UITableView!
    
    private var all_movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.all_movies = Movies_json.shared.get_all_movies()
        
        trailerView.reloadData()
        trailerView.separatorStyle = .singleLine
        trailerView.dataSource = self
        trailerView.delegate = self
        
        trailerView.rowHeight = UITableView.automaticDimension
        trailerView.estimatedRowHeight = 350
        // Do any additional setup after loading the view.
    }
    
}

extension TrailerViewController: UITableViewDataSource, UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all_movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  trailerView.dequeueReusableCell(withIdentifier: "trailerViewCell", for: indexPath) as? TrailerViewCell else{
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return cell
        }
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        //print(all_movies[indexPath.row].title)
        //print(all_movies[indexPath.row].image.url)
        cell.movie_img.contentMode = .scaleAspectFit
        cell.populate(movie: all_movies[indexPath.row], indexPath: indexPath)
        return cell
    }
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }*/
    
}
