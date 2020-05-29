//
//  UIView+Extension.swift
//  ContacttoSOS
//
//  Created by Guilherme Leite Colares on 23/03/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import UIKit

extension UIView {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    func startLoader(withProgress: Bool? = nil) {
        let distanceToBottom = CGFloat(100)
        let progressBarSize = CGFloat(200)

        let viewLoading = UIView(frame: self.frame)
        viewLoading.tag = 99999
        viewLoading.backgroundColor = UIColor.black
        viewLoading.alpha = 0.3
        viewLoading.center = self.center
        
        let loader = UIActivityIndicatorView(style: .whiteLarge)
        loader.startAnimating()
        loader.center = viewLoading.center
        viewLoading.addSubview(loader)
        
        if withProgress != nil {
            viewLoading.alpha = 0.7
            
            let progressView = UIProgressView(progressViewStyle: .bar)
            progressView.tag = 99998
            progressView.frame = CGRect(
                x: viewLoading.center.x - progressBarSize/2,
                y: viewLoading.frame.height - distanceToBottom,
                width: progressBarSize,
                height: 20
            )
            progressView.setProgress(0.0, animated: true)
            progressView.trackTintColor = .lightGray
            progressView.tintColor = .white
            viewLoading.addSubview(progressView)
        }
        
        self.addSubview(viewLoading)
        self.bringSubviewToFront(viewLoading)
    }
    
    func stopLoader() {
        self.subviews.forEach { view in
            if view.tag == 99999 {
                view.removeFromSuperview()
            }
        }
    }
}
