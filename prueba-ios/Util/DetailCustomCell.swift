//
//  DetailCustomCell.swift
//  prueba-ios
//
//  Created by Guille on 7/1/23.
//

import UIKit

class DetailCustomCell: UITableViewCell {

    // MARK: - Outlets
    
    /// The outlet of the label view.
    @IBOutlet weak var labelC: UILabel!
    /// The outlet of the second text field view.
    @IBOutlet weak var textFieldC: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelC.font = UIFont.boldSystemFont(ofSize: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
