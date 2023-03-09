//
//  AccessibleAuthorLabelSwiftUI.swift
//  AccessibleAuthorPlayground
//
//  Created by Quin Marilyn on 2023-03-09.
//

import SwiftUI

/// A View that automatically generates better accessibility labels for strings that contain
/// complex mathematical characters as a fancy way of styling text.
struct AccessibleLabel: View {
    let text: String
    
    /// Statically (lazily) load our mapping plist file, so it's loaded only when first used and kept around afterwards.
    static let characterMapping: [String: String] = {
        guard let plistURL = Bundle.module.url(forResource: "mapping", withExtension: "plist") else { return [:] }
        guard let mapping = NSDictionary(contentsOf: plistURL) as? [String: String] else { return [:] }
        return mapping
    }()
    
    var body: some View {
	    /// Automatically converts our text into something easier for VoiceOver to read.
        Text(text.map { Self.characterMapping[$0.lowercased()] ?? "" }.joined())
            .accessibilityLabel(text)
    }
}
