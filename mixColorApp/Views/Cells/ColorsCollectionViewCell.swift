//
//  ColorsCollectionViewCell.swift
//  mixColorApp
//
//  Created by Nikita Savchik on 31/10/2023.
//

import UIKit

class ColorsCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                layer.borderWidth = 2
            } else {
                layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                layer.borderWidth = 0.5
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        layer.borderWidth = 0.1
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.cornerRadius = layer.frame.size.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
