//
//  MVCProtocol.swift
//  MVCTest
//
//  Created by 张淏 on 2022/3/7.
//

import UIKit

protocol MVCBaseProtocol: UIViewController {
    static var getClass: UIViewController.Type { get }
    static var getContainer: UIView.Type { get }
}

protocol MVCProtocol: MVCBaseProtocol {
    
    associatedtype Container: UIView
    var container: Container { get }
}

extension MVCProtocol  {
    var container: Container { view as! Container }
    static var getClass: UIViewController.Type { return Self.self }
    static var getContainer: UIView.Type { return Container.self }
}

// 要实现 Controller、View 分离的控制器在下边统一遵守该协议
extension ViewController: MVCProtocol { typealias Container = XXView }
extension AController: MVCProtocol { typealias Container = AView }
extension BController: MVCProtocol { typealias Container = BView }
//extension <#UIViewController#>: MVCProtocol { typealias Container = <#UIView#> }
//extension <#UIViewController#>: MVCProtocol { typealias Container = <#UIView#> }
