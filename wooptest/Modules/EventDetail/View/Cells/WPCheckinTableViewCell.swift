//
//  WPCheckinTableViewCell.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import UIKit

class WPCheckinTableViewCell: UITableViewCell {

    @IBOutlet weak var checkinButton: UIButton! {
        didSet {
            checkinButton.layer.cornerRadius = 3
            checkinButton.layer.masksToBounds = true
        }
    }
    
}
