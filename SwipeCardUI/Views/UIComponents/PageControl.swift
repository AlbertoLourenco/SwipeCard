//
//  PageControl.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/16/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    
    var page: Int = 0
    var total: Int = 0
    
    func makeUIView(context: UIViewRepresentableContext<PageControl>) -> UIPageControl {
        
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.numberOfPages = total
        
        return pageControl
    }
    
    func updateUIView(_ view: UIPageControl, context: UIViewRepresentableContext<PageControl>) {
        view.currentPage = page
    }
}
