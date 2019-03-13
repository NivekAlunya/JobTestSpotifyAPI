//
//  SpotifyRest.swift
//  MyMusicList
//
//  Created by Kevin Launay on 11/03/2019.
//  Copyright © 2019 Kevin Launay. All rights reserved.
//

import UIKit
import Alamofire

class SpotifyAPI {
    private static var access_token  = ""
    private static let authorization = "MDdjNGU2MTdkMWM0NDAxYzhmOWVhYTgwOTRhYjQ4NGQ6ODY2YzBiYzNhNjg2NGZmNzlhOGZhNTY2NDQwZjk5Y2Q="
    
    class func setToken(token: String) {
        SpotifyAPI.access_token = token
    }
    
    enum SpotifyAPIError: Error {
        case notokenProvided
    }
    
    enum EndPoint: URLRequestConvertible {
        case token
        //@todo need an enum for add type search criteria
        case search(query: String)
        
        private func accesToken() throws -> URLRequest {
            let url = try "https://accounts.spotify.com/api/token".asURL()
            
            var request = URLRequest(url: url)
            request.setValue("Basic \(SpotifyAPI.authorization)", forHTTPHeaderField: "Authorization")
            request.httpMethod = HTTPMethod.post.rawValue
            return try URLEncoding.default.encode(request, with: ["grant_type" : "client_credentials"])
        }
        
        private static let baseurl  = "https://api.spotify.com/v1"

        func asURLRequest() throws -> URLRequest {
            var parameters: [String: String]!;
            var endpoint: String!
            
            switch self {
            case .token:
                return try accesToken()
            //@todo add paging and type
            case let .search(query):
                endpoint = "/search"
                parameters = ["q": query, "type": "artist"]
            }
            
            if (SpotifyAPI.access_token == "") {
                throw SpotifyAPIError.notokenProvided
            }
            
            let url = try EndPoint.baseurl.asURL()
            var request = URLRequest(url: url.appendingPathComponent(endpoint))
            
            request.setValue("Bearer \(SpotifyAPI.access_token)", forHTTPHeaderField: "Authorization")

            return try URLEncoding.default.encode(request, with: parameters)
        }
    }
    

}
