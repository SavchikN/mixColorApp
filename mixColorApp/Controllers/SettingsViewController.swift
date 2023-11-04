//
//  SettingsViewController.swift
//  mixColorApp
//
//  Created by Nikita Savchik on 30/10/2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func settingsVCDidDismiss()
}

class SettingsViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Settings"
        title.font = .rounded(ofSize: 35, weight: .bold)
        title.textColor = .black
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let firstColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose first color:"
        label.font = .rounded(ofSize: 25, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose second color:"
        label.font = .rounded(ofSize: 25, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let secondColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .rounded(ofSize: 25, weight: .medium)
        button.layer.cornerRadius = 17
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let colorPicker: UIColorPickerViewController = {
        let colorPicker = UIColorPickerViewController()
        colorPicker.supportsAlpha = false
        return colorPicker
    }()
    
    var selectedColorView: UIView?
    weak var delegate: SettingsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        addTapGesture(firstColorView)
        addTapGesture(secondColorView)
        setConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(firstColorView)
        view.addSubview(secondColorView)
        view.addSubview(firstColorLabel)
        view.addSubview(secondColorLabel)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
    }
    
    private func returnToMainVC() {
        UIView.animate(withDuration: 0.3, animations: {
            self.dismiss(animated: true)
        }) { _ in
            self.delegate?.settingsVCDidDismiss()
        }
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        selectedColorView?.backgroundColor = viewController.selectedColor
        print("hello hei world")
    }
    
    @objc func showColorPicker(_ gesture: UITapGestureRecognizer) {
        if let sheet = colorPicker.sheetPresentationController {
            sheet.detents = [.custom { context in
                let customOffset: CGFloat = 150
                let mediumHeight = context.maximumDetentValue * 0.5
                return mediumHeight + customOffset
            }]
            sheet.preferredCornerRadius = 20
        }
        
        if let colorView = gesture.view {
            selectedColorView = colorView
            colorPicker.delegate = self
            present(colorPicker, animated: true)
        }
    }
    
    @objc func saveButtonTapped() {
        returnToMainVC()
    }
    
    @objc func cancelButtonTapped() {
        returnToMainVC()
    }
    
    private func addTapGesture(_ view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showColorPicker))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -11),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.widthAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            titleLabel.widthAnchor.constraint(equalToConstant: 180),
            
            firstColorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            firstColorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstColorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            firstColorView.topAnchor.constraint(equalTo: firstColorLabel.bottomAnchor, constant: 20),
            firstColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstColorView.heightAnchor.constraint(equalToConstant: 50),
            firstColorView.widthAnchor.constraint(equalToConstant: 350),
            
            secondColorLabel.topAnchor.constraint(equalTo: firstColorView.bottomAnchor, constant: 20),
            secondColorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondColorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            secondColorView.topAnchor.constraint(equalTo: secondColorLabel.bottomAnchor, constant: 20),
            secondColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondColorView.heightAnchor.constraint(equalToConstant: 50),
            secondColorView.widthAnchor.constraint(equalToConstant: 350),
            
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
