//
//  ColorPickerViewController.swift
//  mixColorApp
//
//  Created by Nikita Savchik on 04/11/2023.
//

import UIKit

class ColorPickerViewController: UIColorPickerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
    
}

extension ColorPickerViewController: UIColorPickerViewControllerDelegate {
    
}
