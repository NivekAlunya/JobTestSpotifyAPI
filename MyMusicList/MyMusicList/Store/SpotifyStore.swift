//
//  SpotifyStore.swift
//  MyMusicList
//
//  Created by Kevin Launay on 11/03/2019.
//  Copyright © 2019 Kevin Launay. All rights reserved.
//

import UIKit
import Alamofire

class SpotifyStore {
    
    static let shared = SpotifyStore()
    
    var artistSearched = [Artist]()
    
    private init() {
        
    }
    
    func searchArtist(term: String, complete: @escaping ()->() ) {
        //@todo can complete with cached data
        
        Alamofire.request(SpotifyAPI.EndPoint.search(query: term)).responseJSON(queue: nil, options: []) { (response) in
            switch response.result {
                
            case .success(let json):
                guard let json = json as? [String: Any] else {
                        return
                }
                print(json)
                self.artistSearched = self.loadSearchArtist(json: json)
                
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
            
            complete()
        }
    }
    
    func loadSearchArtist(json: [String: Any]) -> [Artist] {
        //process artists
        guard let artists = json["artists"] as? [String: Any],
            let items = artists["items"] as? [[String: Any]]
        else {
            return []
        }
        print(items)
        var list = [Artist]()
        for item in items {
            let name = item["name"]! as! String
            let genres = item["genres"]! as! [String]
            guard let images = item["images"] as? [[String:Any]] else {
                continue;
            }
            //choose the smallest image in the
            var url: String? = nil
            var minHeight = Int.max
            for image in images {
                guard let height = image["height"] as? Int else {
                    continue
                }
                if height < minHeight {
                    url = image["url"]! as? String
                    minHeight = height
                }
            }
            
            let artist = Artist(name: name, image: url, genres: genres)
            
            list.append(artist)
        }
        return list
    }
}
