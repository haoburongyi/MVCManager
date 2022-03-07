//
//  ViewController.swift
//  MVCTest
//
//  Created by 张淏 on 2022/3/3.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        container.set(image: #imageLiteral(resourceName: "popover_icon"))
        container.set(title: "点击屏幕跳转至 AController")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(AController(), animated: true)
    }
}

