//
//  SecondProfileCell.swift
//  movies_tableView
//
//  Created by Kunjeti Jassvanthh on 21/09/21.
//

import UIKit

class SecondProfileCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var number: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
