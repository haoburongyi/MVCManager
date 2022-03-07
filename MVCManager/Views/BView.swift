//
//  BView.swift
//  MVCTest
//
//  Created by 张淏 on 2022/3/7.
//

import Foundation
import UIKit

class BView: UIView {
    
    private lazy var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        backgroundColor = .white
        titleLabel.text = "BController 的 BView"
        titleLabel.sizeToFit()
        titleLabel.textColor = .black
        let screenSize = UIScreen.main.bounds.size
        titleLabel.center = .init(x: screenSize.width * 0.5, y: screenSize.height * 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
