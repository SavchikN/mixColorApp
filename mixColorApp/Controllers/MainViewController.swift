//
//  MainViewController.swift
//  mixColorApp
//
//  Created by Nikita Savchik on 29/10/2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private let firstColorLabel: UILabel = {
        let label = UILabel()
        label.text = "First color:"
        label.font = .rounded(ofSize: 30, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Second color:"
        label.font = .rounded(ofSize: 30, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.font = .rounded(ofSize: 30, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mixButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Result", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .rounded(ofSize: 25, weight: .regular)
        button.backgroundColor = .white
//        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var blurEffectView: UIVisualEffectView?

    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupUI()
        setupNavBar()
        setupBlurEffect()
        setConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupSubviews(
            firstColorLabel,
            secondColorLabel,
            plusLabel,
            mixButton
        )
        setupGradientLayer()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "MixColors"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: setupBarButton())
    }
    
    private func setupBarButton() -> UIButton {
        let settingsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        settingsButton.setBackgroundImage(UIImage(systemName: "gear"), for: .normal)
        settingsButton.tintColor = .black
        settingsButton.addTarget(self, action: #selector(showSettingsVC), for: .touchUpInside)
        return settingsButton
    }
    
    private func setupSubviews(_ subview: UIView...) {
        subview.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView = blurEffectView
        blurEffectView.alpha = 0.0
        view.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
        print("method was called")
        blurEffectView?.alpha = 0.0
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func showSettingsVC() {
        let settingsVC = SettingsViewController()
        settingsVC.delegate = self
        settingsVC.isModalInPresentation = true
        
        if let sheet = settingsVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 21
        }
        
        present(settingsVC, animated: true)
        
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.isHidden = true
            self.blurEffectView?.alpha = 1.0
        }
    }
}

extension MainViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            firstColorLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            firstColorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            plusLabel.topAnchor.constraint(equalTo: firstColorLabel.bottomAnchor, constant: 80),
            plusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            plusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            secondColorLabel.topAnchor.constraint(equalTo: plusLabel.bottomAnchor, constant: 90),
            secondColorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mixButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            mixButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mixButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

extension MainViewController {
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        let firstColor = UIColor.systemPurple.cgColor
        let secondColor = UIColor.systemBlue.cgColor
        
        gradientLayer.colors = [firstColor, secondColor]
        gradientLayer.startPoint = CGPoint(x: 0.6, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.6, y: 1)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func settingsVCDidDismiss() {
        removeBlurEffect()
    }
}
