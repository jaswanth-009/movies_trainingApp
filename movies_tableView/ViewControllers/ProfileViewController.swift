//
//  ProfileViewController.swift
//  movies_tableView
//
//  Created by Kunjeti Jassvanthh on 21/09/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    
    private var profiles = [Profile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profiles.append(Profile(nm: "Jaswanth", num: "1234567890", em: "jaswanth@gmail.com"))
        profiles.append(Profile(nm: "John", num: "0987654321", em: "john@gmail.com"))
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.estimatedRowHeight = 300
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return profiles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            guard let cell = profileTableView.dequeueReusableCell(withIdentifier: "firstProfileCell") as? FirstProfileCell else {
                let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                return cell
            }
            cell.person_img.layer.cornerRadius = cell.person_img.frame.height/2
            cell.person_img.image = UIImage(named: String(indexPath.section))
            return cell
        }
        else{
            guard let cell = profileTableView.dequeueReusableCell(withIdentifier: "secondProfileCell") as? SecondProfileCell else {
                let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                return cell
            }
            cell.name.text = profiles[indexPath.section].name
            cell.email.text = profiles[indexPath.section].email
            cell.number.text = profiles[indexPath.section].number
            return cell
        }
    }
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 220
    }*/
}
