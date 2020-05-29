//
//  WPEventTableViewCell.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import UIKit
import ImageLoader

class WPEventTableViewCell: UITableViewCell {
    
    // MARK: Proprietes
    var event: WPEvent! {
        didSet {
            lblTitle.text = event.title
            bannerImageView.load.request(with: event.image)
            //format date
            lblDay.text = "\(event.dateObj.day)"
            lblMonth.text = event.dateObj.monthName(.short)
        }
    }
    
    // MARK: @IBOutlets
    @IBOutlet weak var bannerImageView: UIImageView! {
        didSet {
            bannerImageView.layer.cornerRadius = 3
            bannerImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var infoView: UIView! {
        didSet {
            infoView.layer.cornerRadius = 3
            infoView.layer.masksToBounds = true
            infoView.layer.borderWidth = 0.5
            infoView.layer.borderColor = UIColor.gray.cgColor
        }
    }
   
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
}
