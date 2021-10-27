//
//  SectionHeader.swift
//  movies_tableView
//
//  Created by Kunjeti Jassvanthh on 16/09/21.
//

import UIKit

class SectionHeader: UITableViewCell {

    
   
    @IBOutlet weak var header_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
