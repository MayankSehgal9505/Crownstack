//
//  ShimmerTableViewCell.swift
//  CrownStack_Assignment
//
//  Created by Mayank Sehgal on 26/07/21.
//

import UIKit

class ShimmerTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var shimmerImgView: UIImageView!

    static let identifier = String(describing: ShimmerTableViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        shimmerImgView.showView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
