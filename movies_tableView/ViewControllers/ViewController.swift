//
//  ViewController.swift
//  movies_tableView
//
//  Created by Kunjeti Jassvanthh on 10/09/21.
//

import UIKit

class ViewController: UIViewController {

    private var favourites = [Movie]()
    private var movie_list = [Movie]()
    var sections: [[Movie]]? 
    let section_headers = ["Favourites","Movie List"]
    
    @IBOutlet weak var IMdb_img: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.IMdb_img.contentMode = .scaleAspectFill
        (self.favourites,self.movie_list) = Movies_json.shared.get_movies()
        self.sections = [self.favourites,self.movie_list]
        tableView.reloadData()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 270
        
        tableView.separatorStyle = .singleLine
    
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections![section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header_cell = tableView.dequeueReusableCell(withIdentifier: "sectionHeader") as! SectionHeader
        header_cell.header_name.text = section_headers[section]
        return header_cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell else{
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return cell
        }
        cell.selectionStyle = .none
        cell.delegate_obj = self
        cell.tag = indexPath.row
        let movie = sections![indexPath.section][indexPath.row]
        cell.setup_cell(index_Path: indexPath,movie: movie)
        return cell
    }
}

extension ViewController: MyDelegate
{
    func didClick(button_state: UIButton, cell_no: Int) {
        if(button_state.tintColor == UIColor.blue){
            tableView.beginUpdates()
            sections![0].insert(sections![1][cell_no], at: 0)
            tableView.deleteRows(at: [IndexPath(row: cell_no, section: 1)], with: .bottom)
            sections![1].remove(at: cell_no)
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .bottom)
            tableView.endUpdates()
            Movies_json.shared.update_movies(fav: sections![0], mov: sections![1])
            }
        else{
            tableView.beginUpdates()
            sections![1].insert(sections![0][cell_no], at: 0)
            tableView.deleteRows(at: [IndexPath(row: cell_no, section: 0)], with: .bottom)
            sections![0].remove(at: cell_no)
            tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .bottom)
            tableView.endUpdates()
            Movies_json.shared.update_movies(fav: sections![0], mov: sections![1])
        }
        //tableView.reloadData()
    }
}

