//
//  CMYPageView.swift
//  CMYPageView
//
//  Created by 程明勇 on 2018/7/4.
//  Copyright © 2018年 程明勇. All rights reserved.
//

import UIKit

class CMYPageView: UIView {
    
    // MARK: 定义属性
    fileprivate var titles: [String]!
    fileprivate var childVcs: [UIViewController]!
    fileprivate weak var parentVc: UIViewController!
    fileprivate var style: CMYTitleStyle!
    
    fileprivate var titleView: CMYTitleView!
    fileprivate var contentView: CMYContentView!
    
    // MARK: 自定义构造函数
    init(frame: CGRect, titles: [String], style: CMYTitleStyle, childVCs: [UIViewController], parentVc: UIViewController) {
        super.init(frame: frame)
        
        //        assert(titles.count == childVcs.count, "标题和控制前个数不同!") // 测试
        self.style = style
        self.titles = titles
        self.childVcs = childVCs
        self.parentVc = parentVc
        
        parentVc.automaticallyAdjustsScrollViewInsets = false
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面内容
extension CMYPageView {
    fileprivate func setupUI() {
        let titleH: CGFloat = style.titleHeight
        let titleFrame = CGRect(x: 0, y: 0, width: frame.width, height: titleH)
        titleView  = CMYTitleView(frame: titleFrame, titles: titles, style: style)
        titleView.delegate = self
        addSubview(titleView)
        
        let contentFrame = CGRect(x: 0, y: titleH, width: frame.width, height: frame.height - titleH)
        contentView = CMYContentView(frame: contentFrame, childVcs: childVcs, parentViewController: parentVc)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.delegate = self
        addSubview(contentView)
    }
}

// MARK:- 设置CMYContentView的代理
extension CMYPageView: CMYContentViewDelegate {
    func contentView(_ contentView: CMYContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func contentViewEndScroll(_ contentView: CMYContentView) {
        titleView.contentViewDidEndScroll()
    }
}

// MARK:- 设置CMYTitleView的代理
extension CMYPageView: CMYTitleViewDelegate {
    func titleView(_ titleView: CMYTitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}
