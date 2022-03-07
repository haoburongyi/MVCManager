//
//  AController.swift
//  MVCTest
//
//  Created by 张淏 on 2022/3/7.
//

import UIKit

class AController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "AController 点击屏幕跳转至 BController"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(BController(), animated: true)
    }
}
