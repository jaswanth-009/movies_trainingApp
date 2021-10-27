//
//  CelebViewController.swift
//  movies_tableView
//
//  Created by Kunjeti Jassvanthh on 16/09/21.
//

import UIKit

class TopRatedMovieController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchContainerView: UIView!
    
    private let searchController = UISearchController(searchResultsController: nil) // nil here is used as we use same view controller to display  results and we tell this by making definesPresentationContext as true
    private var searchActive: Bool = false
    private var search_results = [Movie]()
    
    private var watch_list = [String]()
    private var top_mov_list = [Movie]()
    
    override func loadView() {
        super.loadView()
    }
    /*override required init?(coder: NSCoder) {
        <#code#>
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.top_mov_list = Movies_json.shared.getTopRatedMovies()//viewdidappear
    
        searchController.searchBar.placeholder = "Search Movies"
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false // generally, the background view is dimmed when searching, since we are using same view to display results, it should not be dimmed, so setting to false
        searchController.searchBar.setShowsCancelButton(true, animated: true) // Searchbar has 2 buttons, "Cancel" button and "x" button , both with same functionality of dismissing text entered and also keyboard. One button serves this purpose, so setting this to false removes "Cancel" button
        searchController.searchBar.searchTextField.clearButtonMode = .never
        searchController.searchBar.delegate = self // delegating for UISearchBarDelegate
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
   
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var chset = NSCharacterSet.letters
        chset.insert(charactersIn: "\n")
        let input = CharacterSet(charactersIn: text)
        return chset.isSuperset(of: input)
    }
    
    
    @IBAction func animate_button(_ sender: UIButton) {
        UIView.animate(withDuration: 2.0, animations: {
            sender.transform = CGAffineTransform(scaleX: 2, y: 2)
            sender.tintColor = UIColor.red
        },completion: {_ in
            UIView.animate(withDuration: 2, animations: {sender.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            sender.tintColor = .black})
            let alert = UIAlertController(title: "Watch List", message: "", preferredStyle: .actionSheet)
            for i in 0..<self.watch_list.count{
                alert.addAction(UIAlertAction(title: self.watch_list[i], style: .default, handler: nil))
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
}

extension TopRatedMovieController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive{
            return search_results.count
        }
        else{
        return self.top_mov_list.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topRatedMovieCell", for: indexPath) as? TopRatedMovieCell else{
            let cell = UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return cell
        }
        if(searchActive){
            cell.tag = indexPath.row
            cell.delegate_watchlist = self
            let top_movie = search_results[indexPath.row]
            cell.populate(movie: top_movie, indexPath: indexPath)
        }
        else{
        cell.tag = indexPath.row
        cell.delegate_watchlist = self
        let top_movie = top_mov_list[indexPath.row]
        cell.populate(movie: top_movie, indexPath: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
}

extension TopRatedMovieController: Add_to_Watchlist{
    func add_movie(mov_name: String) {
        if(!self.watch_list.contains(mov_name)){
            self.watch_list.append(mov_name)}
    }
}

extension TopRatedMovieController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        if !(searchText!.isEmpty)
        {
            searchActive = true
            search_results.removeAll()
            for movie in top_mov_list
            {
                if movie.title.lowercased().contains(searchText!.lowercased()){
                    search_results.append(movie)
                }
            }
        }
        else
        {
            searchActive = false
            search_results.removeAll()
            search_results = top_mov_list
        }
        collectionView.reloadData()
    }
}

extension TopRatedMovieController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        //searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        search_results.removeAll()
        searchBar.endEditing(true)
        collectionView.reloadData()
    }
}

