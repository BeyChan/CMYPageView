//
//  ViewController.swift
//  CMYPageView
//
//  Created by 程明勇 on 2018/7/4.
//  Copyright © 2018年 程明勇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         setupContentView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    fileprivate func setupContentView() {
        
        // 1.frame
        let pageViewFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        // 2.titles
        let titles = ["火箭", "骑士", "湖人", "勇士", "马刺", "活塞","凯尔特人", "76人", "步行者","掘金"]
        
        // 3.titleView样式
        let style = CMYTitleStyle()
        style.titleHeight = 44
        style.isScrollEnable = true
        style.isNeedScale = true
        style.isShowCover = true
        
        // 4.初始化所有子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(vc)
        }
        
        // 5.创建JQPageView
        let pageView = CMYPageView(frame: pageViewFrame, titles: titles, style: style, childVCs: childVcs, parentVc: self)
        
        // 6.将pageView添加到控制器View中
        view.addSubview(pageView)
    }

    
}

