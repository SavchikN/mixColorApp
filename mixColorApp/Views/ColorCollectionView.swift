//
//  ColorCollectionView.swift
//  mixColorApp
//
//  Created by Nikita Savchik on 31/10/2023.
//

import UIKit

class ColorCollectionView: UIView {
    
    let colors = [#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)]
    
    private let colorCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
//        collectionViewLayout.itemSize = CGSize(width: 100, height: 100)
//        collectionViewLayout.minimumLineSpacing = 10
//        collectionViewLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(colorCollectionView)
        colorCollectionView.register(ColorsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            colorCollectionView.topAnchor.constraint(equalTo: topAnchor),
            colorCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension ColorCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection called")
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ColorsCollectionViewCell else { return UICollectionViewCell() }
        print("cellForItemAt called")
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
}

extension ColorCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60, height: 60)
    }
}
