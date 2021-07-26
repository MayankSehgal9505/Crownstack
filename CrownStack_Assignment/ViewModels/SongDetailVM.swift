//
//  SongDetailVM.swift
//  CrownStack_Assignment
//
//  Created by Mayank Sehgal on 26/07/21.
//

import Foundation
import SDWebImage

typealias HeadLineDetailData = (String?,String?,String?,String?) // Title,Description,Date,Artist

final class SongDetailVM: NSObject{
    
    var dataSource: Song!
    
    init(model: Song) {
        dataSource = model
    }
    
    func fetchImage(imgView: UIImageView){
        guard let url = dataSource.artworkUrl100 else {return}
        imgView.sd_setImage(with: URL(string: url), completed: nil)
    }
    
    func getVisualData()->HeadLineDetailData{
        return (dataSource?.trackName, dataSource?.trackName, getFormattedDate(),dataSource?.artistName)
    }
    
    private func getFormattedDate()-> String?{
        guard let releaseDate = dataSource.releaseDate else {return nil}
        return String(describing: releaseDate.prefix(10))
    }
    
}
