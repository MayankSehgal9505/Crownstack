//
//  SongsListServiceHandler.swift
//  CrownStack_Assignment
//
//  Created by Mayank Sehgal on 26/07/21.
//

import Foundation

private struct SongsListRequestBuilder: RequestType {
    typealias ResponseType = SongsListModel
    var data: RequestData
}

final class SongsListyServiceHandler{
    static let shared = SongsListyServiceHandler()
    func getSongs(completion: @escaping(SongsListModel?,Error?)->Void){
        let reqData = RequestData(path: EndPoints.getSongsList.rawValue, method: .get)
        let request = SongsListRequestBuilder(data: reqData)
        request.execute(onSuccess: { (response) in
            completion(response,nil)
        }) { (error) in
            completion(nil,error)
        }
    }
}
