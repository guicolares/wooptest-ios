//
//  WPBannerTableViewCell.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import UIKit

class WPBannerTableViewCell: UITableViewCell {
    
    var urlBanner: String? {
        didSet {
            bannerImageView.load.request(with: urlBanner ?? "") 
        }
    }
    
    @IBOutlet weak var bannerImageView: UIImageView!
}
