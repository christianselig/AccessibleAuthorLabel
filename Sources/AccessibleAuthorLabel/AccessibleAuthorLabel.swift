//
//  AccessibleAuthorLabel.swift
//  AccessibleAuthorPlayground
//
//  Created by Christian Selig on 2021-12-21.
//

import UIKit

/// A UILabel subclass that automatically generates better accessibility labels for strings that contain
/// complex mathematical characters as a fancy way of styling text.
public class AccessibleLabel: UILabel {
    /// Statically (lazily) load our mapping plist file, so it's loaded only when first used and kept around afterwards.
    static let characterMapping: [String: String] = {
        guard let plistURL = Bundle.module.url(forResource: "mapping", withExtension: "plist") else { return [:] }
        guard let mapping = NSDictionary(contentsOf: plistURL) as? [String: String] else { return [:] }
        return mapping
    }()
    
    private var _accessibilityLabel: String?

    /// If accessibilityLabel is not set, converts our text into something easier for VoiceOver to read.
    override public var accessibilityLabel: String? {
        get {
            _accessibilityLabel ?? text?.map { Self.characterMapping[$0.lowercased()] ?? "" }.joined()
        }

        set {
            _accessibilityLabel = newValue
        }
    }
}
