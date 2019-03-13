//
//  ViewController.swift
//  MyMusicList
//
//  Created by Kevin Launay on 11/03/2019.
//  Copyright © 2019 Kevin Launay. All rights reserved.
//

import UIKit
import Nuke
class SpotifySearchViewController: UIViewController {

    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tvSearch: UITableView!
    
    @IBAction func touchSearch(_ sender: Any) {
        guard let term = tfSearch.text, term.lengthOfBytes(using: String.Encoding.unicode) > 0 else {
            return
        }
        tfSearch.resignFirstResponder()
        presenter.search(term: term)
    }
    
    var presenter: SpotifySearchPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    func setup() {
        self.title = "Search Spotify"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        presenter = SpotifySearchPresenter(delegate: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SpotifyArtistViewController {
            vc.artist = presenter.selectedArtist
        }
    }
}

extension SpotifySearchViewController: SpotifySearchPresenterDelegate {
    func onSearchCompleted() {
        tvSearch.reloadData()
    }
}

extension SpotifySearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.selectAt(index: indexPath.row)
        self.performSegue(withIdentifier: Application.StoryboardSeque.gotoArtist.rawValue, sender: self)
    }
}

extension SpotifySearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.artistList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Application.TableViewCellID.artist.rawValue, for: indexPath) as! ArtistCell
        
        let artist = self.presenter.artistList[indexPath.row]
        
        var label = "\(artist.name!)\n"
        for genre in artist.genres {
            label = "\(label)[\(genre)] "
        }
        cell.lblArtist.text = label
        
        
        if let url = artist.image {
            Nuke.loadImage(with: URL(string: url)!, into: cell.ivArtist)
        } else {
            cell.ivArtist.image = nil
        }
        
        return cell
    }
    
    
}
