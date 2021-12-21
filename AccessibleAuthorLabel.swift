//
//  AccessibleAuthorLabel.swift
//  AccessibleAuthorPlayground
//
//  Created by Christian Selig on 2021-12-21.
//

import UIKit

class AccessibleAuthorLabel: UILabel {
    override var accessibilityLabel: String? {
        get {
            guard let text = text else { return nil }
            
            let plistURL = Bundle.main.url(forResource: "mapping", withExtension: "plist")!
            let mapping = NSDictionary(contentsOf: plistURL) as! [String: String]
            
            let convertedResult = text.map(String.init).map { mapping[$0.lowercased()] ?? "" }.joined()
            return convertedResult
        } set {
            super.accessibilityLabel = newValue
        }
    }
    
    
}

