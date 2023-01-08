//
//  CustomCell.swift
//  prueba-ios
//
//  Created by Guille on 7/1/23.
//

import UIKit

class CustomCell: UITableViewCell {

    // MARK: - Outlets
    
    /// The outlet of the image view containing the cell image.
    @IBOutlet weak var imageC: UIImageView!
    /// The outlet of the first label view.
    @IBOutlet weak var firstLabelC: UILabel!
    /// The outlet of the second label view.
    @IBOutlet weak var secondLabelC: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.firstLabelC.font = UIFont.boldSystemFont(ofSize: 20)
        firstLabelC.textColor = .blue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
