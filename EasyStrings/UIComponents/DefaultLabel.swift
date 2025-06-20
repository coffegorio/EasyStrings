//
//  DefaultLabel.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import UIKit

class DefaultLabel: UILabel {

    private enum DefaultValues {
        static let text: String = ""
        static let size: CGFloat = 16
        static let weight: UIFont.Weight = .regular
    }
    
    init(text: String = DefaultValues.text,
         fontSize: CGFloat = DefaultValues.size,
         weight: UIFont.Weight = DefaultValues.weight) {
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textColor = UIColor(named: "TextColor")
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
