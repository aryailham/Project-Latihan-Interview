//
//  PostCell.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import UIKit

class PostCell: UITableViewCell {
    static let ID = "PostCell"
    static let nib = UINib(nibName: "PostCell", bundle: nil)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupData(title: String, body: String) {
        self.titleLabel.text = title
        self.bodyLabel.text = body
    }
    
}
