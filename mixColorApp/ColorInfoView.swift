//
//  ColorInfoView.swift
//  mixColorApp
//
//  Created by Nikita Savchik on 06/11/2023.
//

import UIKit

class ColorInfoView: UIView {
    
    var onClose: (() -> Void)?
    
    var resultColor: UIColor?
    
    lazy var blurView = UIVisualEffectView()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showAnimate(on parentViewController: MainViewController) {
        blurView = UIVisualEffectView(frame: parentViewController.view.bounds)
        setupBlurEffect()
        
        parentViewController.view.addSubview(blurView)
        parentViewController.view.addSubview(self)
        
        setupAnimate()
    }
    
    func setupAnimate() {
        alpha = 0
        blurView.alpha = 0
        transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
            self.alpha = 1
            self.blurView.alpha = 1
            self.transform = .identity
        }
    }
    
    func dismissAnimate() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.blurView.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            self.blurView.removeFromSuperview()
            self.onClose?()
        }
    }
    
    @objc func cancelButtonTapped() {
        dismissAnimate()
    }
}

private extension ColorInfoView {
    func setupUI() {
        backgroundColor = resultColor
        layer.cornerRadius = 20
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.borderWidth = 1
    
        addSubview(cancelButton)
    }
    
    func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        blurView.effect = blurEffect
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
