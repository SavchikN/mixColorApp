//
//  MainViewController.swift
//  mixColorApp
//
//  Created by Nikita Savchik on 29/10/2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var blurEffectView: UIVisualEffectView?
    
    var firstColor = UIColor.systemPurple
    var secondColor = UIColor.systemBlue
    
    let firstColorLabel: UILabel = {
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
//        label.text = "+"
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
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(mixButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupUI()
        setupLabelText()
        setupNavBar()
        setupGradientLayer(firstColor, secondColor)
        setupBlurEffect()
        setConstraints()
    }
    
    func removeBlurEffect() {
        print("method was called")
        blurEffectView?.alpha = 0.0
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupSubviews(
            firstColorLabel,
            secondColorLabel,
            plusLabel,
            mixButton
        )
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
    
    private func setupLabelText() {
        firstColorLabel.text = firstColor.accessibilityName
        secondColorLabel.text = secondColor.accessibilityName
        plusLabel.text = "+"
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
    
    private func setupGradientLayer(_ firstColor: UIColor, _ secondColor: UIColor) {
        if let gradientLayer = view.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        let first = firstColor.cgColor
        let second = secondColor.cgColor
        
        gradientLayer.colors = [first, second]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func mixColors(color1: UIColor, color2: UIColor, weight: CGFloat) -> UIColor {
        var red1: CGFloat = 0
        var green1: CGFloat = 0
        var blue1: CGFloat = 0
        var alpha1: CGFloat = 0

        color1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)

        var red2: CGFloat = 0
        var green2: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha2: CGFloat = 0

        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

        let red = (red1 * (1 - weight)) + (red2 * weight)
        let green = (green1 * (1 - weight)) + (green2 * weight)
        let blue = (blue1 * (1 - weight)) + (blue2 * weight)
        let alpha = (alpha1 * (1 - weight)) + (alpha2 * weight)

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            firstColorLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            firstColorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
//            plusLabel.topAnchor.constraint(equalTo: firstColorLabel.bottomAnchor, constant: 80),
            plusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
    @objc func showSettingsVC() {
        let settingsVC = SettingsViewController()
        settingsVC.delegate = self
        settingsVC.isModalInPresentation = true
        settingsVC.firstColor = firstColor
        settingsVC.secondColor = secondColor
        
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
    
    @objc func mixButtonTapped() {
//        showAlert(title: "Your color:", message: secondColor.accessibilityName)
        firstColorLabel.text = ""
        secondColorLabel.text = ""
        plusLabel.text = mixColors(color1: firstColor, color2: secondColor, weight: 0.5).accessibilityName
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func settingsVCDidDismiss(_ firstColor: UIColor, _ secondColor: UIColor) {
        removeBlurEffect()
        self.firstColor = firstColor
        self.secondColor = secondColor
        setupLabelText()
        setupGradientLayer(firstColor, secondColor)
    }
}

extension MainViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.setupGradientLayer(self.firstColor, self.secondColor)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

