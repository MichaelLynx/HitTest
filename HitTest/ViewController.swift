//
//  ViewController.swift
//  HitTest
//
//  Created by lynx on 2021/3/24.
//  Copyright © 2021 Lynx. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let AView = MView()
    let BView = MView()
    let CView = MView()
    let DView = MView()
    let EView = MView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }

    func setupUI() {
        AView.backgroundColor = .lightGray
        view.addSubview(AView)
        
        BView.backgroundColor = .orange
        AView.addSubview(BView)
        
        CView.backgroundColor = .purple
        AView.addSubview(CView)
        
        DView.backgroundColor = .blue
        CView.addSubview(DView)
        
        EView.backgroundColor = .brown
        CView.addSubview(EView)
        
        let addr = String(format: "self:%p\na:%p\nb:%p\nc:%p\nd:%p\ne:%p", view, AView , BView, CView, DView, EView)
        print("address:\n\(addr)")
        
        AView.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.center.equalToSuperview()
        }
        
        BView.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview().offset(-20)
        }
        
        CView.snp.makeConstraints { (make) in
            make.width.height.equalTo(BView)
            make.center.equalToSuperview().offset(20)
        }
        
        DView.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.right.equalTo(CView).offset(-5)
            make.bottom.equalTo(CView).offset(-5)
        }
        
        EView.snp.makeConstraints { (make) in
            make.width.height.equalTo(DView)
            make.right.equalTo(DView.snp_leftMargin).offset(30)
            make.bottom.equalTo(DView.snp_topMargin).offset(30)
        }
    }
}

class MView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        guard view == self else {
            return view
        }
        guard let superView = view?.superview else {
            return view
        }
        print(String(format: "self:%p, view:%p", self, view!))
        for inView in superView.subviews {
            if let relatePoint = view?.convert(point, to: inView), inView.layer.contains(relatePoint) && inView != view {
                ///点击重叠范围时，更改重叠部位底下视图的颜色，并返回底下的视图。
                inView.backgroundColor = fetchColor()
                return inView
            }
        }
        return view
    }
    
    func fetchColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let alpha = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        
        let color = UIColor.init(red:red, green:green, blue:blue , alpha: alpha)
        return color
    }
}

