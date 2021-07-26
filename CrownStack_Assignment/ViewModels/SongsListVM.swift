//
//  SongsListVM.swift
//  CrownStack_Assignment
//
//  Created by Mayank Sehgal on 26/07/21.
//

import Foundation

enum SongsListLoadStatus:Int{
    case loaded = 0
    case none
}

final class SongsListVM: NSObject{
    
    private var songsDataSource: SongsListModel?
    private var cellViewModel: [SongCellVM] = [SongCellVM]()
    var status: SongsListLoadStatus = .none
    
    override init() {
        super.init()
    }
    
    func getSongsRows()->Int{
        if status == .none {return 5}
        return songsDataSource?.songs?.count ?? 0
    }
    
    func getCellVM(for indexPath: IndexPath)-> SongCellVM?{
        guard let models = songsDataSource?.songs, models.indices.contains(indexPath.row) else {return nil}
        return SongCellVM(model: models[indexPath.row])
    }
    
    func getCellModel(for indexPath: IndexPath)-> Song?{
        guard let models = songsDataSource?.songs, models.indices.contains(indexPath.row) else {return nil}
        return models[indexPath.row]
    }
    
    func requestSongs(success: @escaping (Bool, Error?) -> Void){
        SongsListyServiceHandler.shared.getSongs { [weak self](response, error) in
            self?.status = .loaded
            guard let err = error else {
                self?.songsDataSource = response
                success(true,nil)
                return
            }
            success(false,nil)
            return
            
        }
    }
}
