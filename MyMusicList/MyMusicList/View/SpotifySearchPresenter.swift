//
//  SpotifySearchPresenter.swift
//  MyMusicList
//
//  Created by Kevin Launay on 11/03/2019.
//  Copyright © 2019 Kevin Launay. All rights reserved.
//

import UIKit
import Alamofire

protocol SpotifySearchPresenterDelegate {
    func onSearchCompleted()
}

class SpotifySearchPresenter {
    
    private let delegate: SpotifySearchPresenterDelegate
    
    var selectedArtist: Artist?
    
    var artistList: [Artist] {
        get {
            return SpotifyStore.shared.artistSearched
        }
    }
    
    init(delegate: SpotifySearchPresenterDelegate) {
        self.delegate = delegate
        setup()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func selectAt(index: Int) {
        guard index > -1 && index < artistList.count else {
            selectedArtist = nil
            return
        }
        selectedArtist = artistList[index]
    }
    
    func deselect() {
        selectedArtist = nil
    }
    
    private func setup() {
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { (notification) in
            self.refreshToken()
        }
    }
    
    private func refreshToken() {
        do {
            //@todo manage due date of access token
            //@todo add retrier for alamofire
            //@todo plugged the access_token retriever on api call
            let req = try SpotifyAPI.EndPoint.token.asURLRequest()
            Alamofire.request(req).responseJSON { (response) in
                switch response.result {
                    
                case .success(let json):
                    guard let json = json as? [String: Any],
                    let token = json["access_token"] as? String else {
                        return
                    }
                    SpotifyAPI.setToken(token: token)
                    
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
        } catch {
            print("Problem while retrieving access_token from end point \"\(SpotifyAPI.EndPoint.token)\": \(error).")
        }
    }
    
    func search(term: String) {
        SpotifyStore.shared.searchArtist(term: term) {
            self.delegate.onSearchCompleted()
        }
    }
    
}
