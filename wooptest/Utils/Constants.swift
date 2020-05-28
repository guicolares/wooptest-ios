//
//  Constants.swift
//  ContacttoSOS
//
//  Created by Guilherme Leite Colares on 23/03/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import Foundation
import UIKit

enum KeysJson: String {
    case config = "Config"
    case baseURL = "BaseURL"
}

private let config: [String: Any]? = {
    guard
        let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
        let dicInfo = NSDictionary(contentsOfFile: path),
        let dicConfig = dicInfo[KeysJson.config.rawValue] as? [String: Any]
        else { return nil }
    
    return dicConfig
}()

var baseURL: String = {
    guard
        let urlBase = config?[KeysJson.baseURL.rawValue] as? String
        else { return "" }
    
    return urlBase
}()

struct Constants {
    static let accessTokenKey = "accessTokenKey"
    
    static var hasTopNotch: Bool {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 24
        }
        
        return false
    }
    
    static var bottomSheetSafeArea: CGFloat {
        var heightModifier: CGFloat = 0
        
        if hasTopNotch {
            heightModifier = 34
        }
        
        return heightModifier
    }

    static var smallDevice: Bool {
        return UIScreen.main.bounds.height <= 568
    }
}

struct Config {
    
    static var urlBucket: String = ""
    
    static var version: [String: Any] = [:]
    
    static var hasConfig: Bool {
        return Config.urlBucket != ""
    }
}

enum DateFormat: String {
    case full = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case yearMonthDayHourMinuteSecond = "yyyy-MM-dd HH:mm:ss"
    case yearMonthDay = "yyyy-MM-dd"
    case dayMonthYear = "dd/MM/yyyy"
    case dayMonthYearEnglish = "dd-MM-yyyy"
    case dayMonthHourMinute = "dd/MM HH:mm"
    case day = "dd"
    
    case monthDescription = "MMMM"
    
    case hourMinute = "HH:mm"
}
