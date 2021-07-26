//
//  SongCellVM.swift
//  CrownStack_Assignment
//
//  Created by Mayank Sehgal on 26/07/21.
//

import Foundation
import SDWebImage

typealias VisualData = (String?,String?) // TracK Name, Artist Name

final class SongCellVM: NSObject{
    let songModel: Song?
    
    init(model: Song) {
        songModel = model
    }
    
    func getVisualData()-> VisualData?{
        return (songModel?.trackName, songModel?.artistName)
    }

    func fetchImage(imgView: UIImageView){
        guard let url = songModel?.artworkUrl100 else {return}
        imgView.sd_setImage(with: URL(string: url), completed: nil)
    }
}
