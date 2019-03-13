//
//  Application.swift
//  MyMusicList
//
//  Created by Kevin Launay on 13/03/2019.
//  Copyright © 2019 Kevin Launay. All rights reserved.
//
import UIKit

class Application: NSObject {
    static var storyboards = [String:UIStoryboard]()
    
    enum Storyboard: String {
        case main = "Main"
        func get() -> UIStoryboard {
            if storyboards[self.rawValue] == nil {
                storyboards[self.rawValue] = UIStoryboard(name: self.rawValue, bundle: nil)
            }
            
            return storyboards[self.rawValue]!
        }
    }
    
    enum StoryboardID: String  {
        case search = "SearchVC"
        case artist = "ArtistVC"
    }
    
    enum TableViewCellID: String {
        case artist = "ArtistTableViewCell"
    }

    enum StoryboardSeque: String  {
        case gotoArtist = "GotoArtistSegue"
        case artist = "ArtistVC"
    }

}
