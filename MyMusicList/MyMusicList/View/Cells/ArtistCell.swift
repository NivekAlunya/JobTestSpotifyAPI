//
//  ArtistCell.swift
//  MyMusicList
//
//  Created by Kevin Launay on 13/03/2019.
//  Copyright © 2019 Kevin Launay. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {

    @IBOutlet weak var ivArtist: UIImageView!
    
    @IBOutlet weak var lblArtist: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
