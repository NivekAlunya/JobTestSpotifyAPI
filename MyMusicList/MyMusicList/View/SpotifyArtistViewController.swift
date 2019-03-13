//
//  SpotifyArtistViewController.swift
//  MyMusicList
//
//  Created by Kevin Launay on 13/03/2019.
//  Copyright © 2019 Kevin Launay. All rights reserved.
//

import UIKit

class SpotifyArtistViewController: UIViewController {
    var artist: Artist?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
    }

    func setup() {
        self.title = artist?.name ?? "???"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
