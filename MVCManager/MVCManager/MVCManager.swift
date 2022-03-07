//
//  MVCManager.swift
//  MVCTest
//
//  Created by 张淏 on 2022/3/3.
//

import UIKit

public class MVCManager: NSObject {
    
    static let instance = MVCManager.init()
    private override init() { super.init() }
    fileprivate var controllers: [UIViewController.Type] = []
    fileprivate var views: [UIView.Type] = []
    
    // 首页直接要显示的 Controller 调用该方法
    public func launch(_ models: [(UIViewController.Type, UIView.Type)]) {
        _bindVCs(models)
        DispatchQueue.main.async {
            self.bindVCs()
        }
    }
}

extension UIViewController {
    
    @objc
    fileprivate func appLoadView() {
        
        appLoadView()
        let manager = MVCManager.instance
        guard let index = manager.controllers.firstIndex(where: {
            object_getClass(self) == $0
        }) else { return }
        
        let View = manager.views[index]
        guard object_getClass(view) != View else { return }
        view = View.init()
    }
}

extension MVCManager {
    
    // 延迟交换方法
    private func bindVCs() {
        
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            if let cls = (types[index] as? MVCBaseProtocol.Type)?.getClass,
               let container = (types[index] as? MVCBaseProtocol.Type)?.getContainer {

                let model: (UIViewController.Type, UIView.Type) = (cls, container)
                _bindVC(model)
            }
        }
        types.deallocate()
    }
    
    private func _bindVC(_ model: (UIViewController.Type, UIView.Type)) {
        guard controllers.contains(where: { $0 == model.0 }) == false else { return }
        controllers.append(model.0)
        views.append(model.1)
        swizzle(cls: model.0, original: #selector(model.0.loadView), swizzled: #selector(model.0.appLoadView))
    }
    
    private func _bindVCs(_ models: [(UIViewController.Type, UIView.Type)]) {
        models.forEach { model in
            _bindVC(model)
        }
    }
    
    private func swizzle(cls: AnyClass, original originalSelector: Selector, swizzled swizzledSelector: Selector) {
        
        let originalMethod = class_getInstanceMethod(cls, originalSelector)
        let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
        guard (originalMethod != nil && swizzledMethod != nil) else {
            return
        }
        if class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}
