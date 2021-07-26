//
//  SongTVC.swift
//  CrownStack_Assignment
//
//  Created by Mayank Sehgal on 26/07/21.
//

import UIKit

class SongTVC: UITableViewCell {

    @IBOutlet weak var songImg: UIImageView!{
        didSet {
            songImg.makeCircularView(withBorderColor: .black, withBorderWidth: 2.0, withCustomCornerRadiusRequired: true, withCustomCornerRadius: 10.0)
        }
    }
    @IBOutlet weak var songDescription: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songsParentView: UIView! {
        didSet {
            songsParentView.makeCircularView(withBorderColor: .clear, withBorderWidth: 0.0, withCustomCornerRadiusRequired: true, withCustomCornerRadius: 10.0)
        }
    }
    
    static let identifier = String(describing: SongTVC.self)

    var cellViewModel: SongCellVM!{
        didSet{
            guard let cvm = cellViewModel, let visualData = cvm.getVisualData() else {return}
            songDescription.text = visualData.0
            artistName.text = visualData.1
            cvm.fetchImage(imgView: songImg)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
