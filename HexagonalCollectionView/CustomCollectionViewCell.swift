//
//  CustomCollectionViewCell.swift
//  HexagonalCollectionView
//
//  Created by Mohtasim Abrar Samin on 28/3/22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    var title: UILabel = {
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(title)
        contentView.backgroundColor = .darkGray
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.heightAnchor.constraint(equalToConstant: 30),
            title.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
