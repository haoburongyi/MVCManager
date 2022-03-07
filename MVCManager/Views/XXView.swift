//
//  XXView.swift
//  MVCTest
//
//  Created by 张淏 on 2022/3/3.
//

import UIKit

class XXView: UIView {
    
    private lazy var titleLabel = UILabel()
    private lazy var iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        iconImageView.contentMode = .scaleAspectFill
        
        addSubview(titleLabel)
        addSubview(iconImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.sizeToFit()
        titleLabel.center = center
        iconImageView.frame = .init(x: 100, y: 100, width: 100, height: 100)
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    func set(image: UIImage) {
        iconImageView.image = image
    }
}
