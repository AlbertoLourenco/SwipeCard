//
//  GalleryView.swift
//  SwipeCard
//
//  Created by Alberto Lourenço on 3/16/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

class GalleryScrollView: UIView, UIScrollViewDelegate {
    
    var imgShadow: UIImageView!
    var scrollView: UIScrollView!
    var pageChanged: (_ index: Int) -> Void
    
    init(items: Array<String>, size: CGSize, pageChanged: @escaping (_ index: Int) -> Void) {
        
        self.pageChanged = pageChanged
        
        super.init(frame: CGRect(origin: .zero, size: size))
        
        self.scrollView = UIScrollView(frame: CGRect(origin: .zero, size: size))
        self.scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.autoresizingMask = .flexibleHeight
        self.scrollView.translatesAutoresizingMaskIntoConstraints = true
        self.scrollView.contentSize = CGSize(width: CGFloat(items.count) * UIScreen.main.bounds.width, height: 100)
        
        self.scrollView.maximumZoomScale = 3
        
        for (index, item) in items.enumerated() {
            
            let imgPicture = UIImageView(frame: CGRect(origin: CGPoint(x: CGFloat(index) * UIScreen.main.bounds.width, y: 0), size: size))
            imgPicture.image = UIImage(named: item)
            imgPicture.contentMode = .scaleAspectFill
            imgPicture.clipsToBounds = true

            imgPicture.autoresizingMask = .flexibleHeight
            imgPicture.translatesAutoresizingMaskIntoConstraints = true
            
            self.scrollView.addSubview(imgPicture)
        }

        self.addSubview(self.scrollView)
        
        self.imgShadow = UIImageView(frame: CGRect(origin: .zero, size: UIScreen.main.bounds.size))
        self.imgShadow.image = UIImage(named: "Card-Picture-Shadow")
        self.imgShadow.alpha = 0.8
        self.imgShadow.contentMode = .scaleToFill
        self.imgShadow.clipsToBounds = true
        self.imgShadow.autoresizingMask = .flexibleHeight
        self.imgShadow.translatesAutoresizingMaskIntoConstraints = true
        
        self.addSubview(self.imgShadow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-----------------------------------------------------------------------
    //  MARK: - UIScrollView Delegate
    //-----------------------------------------------------------------------
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageChanged(Int(round(scrollView.contentOffset.x / scrollView.frame.width)))
    }
}

struct GalleryView: UIViewRepresentable {
    
    var size: CGSize = .zero
    var items: Array<String> = []
    var scrollEnabled: Bool = true
    var fullScreen: Bool = false
    
    @Binding var pageIndex: Int
    
    func makeUIView(context: UIViewRepresentableContext<GalleryView>) -> GalleryScrollView {

        let gallery = GalleryScrollView(items: self.items, size: self.size) { (index) in
            self.pageIndex = index
        }
        
        return gallery
    }
    
    func updateUIView(_ view: GalleryScrollView, context: UIViewRepresentableContext<GalleryView>) {
        
        view.scrollView.isUserInteractionEnabled = self.scrollEnabled

        if self.fullScreen {

            UIView.animate(withDuration: 0.3) {
                view.imgShadow.alpha = self.fullScreen ? 0.5 : 0.8
            }
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(size: UIScreen.main.bounds.size,
                    items: MockedData.animals().first!.gallery,
                    scrollEnabled: false,
                    fullScreen: false,
                    pageIndex: .constant(0))
    }
}
