//
//  ScrollView-Wrapper.swift
//  ElongHotel
//
//  Created by MC on 2020/4/22.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI

extension View {
    func scrollOffset(_ position: Binding<CGFloat>) -> some View {
        return ScrollViewWrapper(offset: position, pageEnable: true) { self }
    }
}

struct ScrollViewWrapper<Content>: View where Content : View {
    let offset: Binding<CGFloat>
    var pageEnable: Bool = false
    let content: () -> Content

    init(offset: Binding<CGFloat>, pageEnable: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.offset = offset
        self.pageEnable = pageEnable
        self.content = content
    }

    var body: some View {
        ScrollViewRepresentable(offset: offset, pageEnable: self.pageEnable,content: self.content())
    }
}

struct ScrollViewRepresentable<Content>: UIViewControllerRepresentable where Content: View {
    typealias UIViewControllerType = ScrollViewUIHostingController<Content>
    
    @Binding var offset: CGFloat
    var pageEnable: Bool = false
    let content: Content
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScrollViewRepresentable<Content>>) -> ScrollViewUIHostingController<Content> {
        return ScrollViewUIHostingController(offset: self.$offset, pageEnable: pageEnable, rootView: self.content)
    }
    
    func updateUIViewController(_ uiViewController: ScrollViewUIHostingController<Content>, context: UIViewControllerRepresentableContext<ScrollViewRepresentable<Content>>) {
        uiViewController.scroll(position: self.offset)
    }
}

class ScrollViewUIHostingController<Content>: UIHostingController<Content> where Content : View {
    var offset: Binding<CGFloat>
    var pageEnable: Bool = false
    
    var ready = false
    var scrollView: UIScrollView? = nil
    
    init(offset: Binding<CGFloat>, pageEnable: Bool, rootView: Content) {
        self.offset = offset
        self.pageEnable = pageEnable
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        override func viewDidAppear(_ animated: Bool) {
        // observer is added from viewDidAppear, in order to
        // make sure the SwiftUI view is already in place
        if ready { return } // avoid running more than once
        
        ready = true
        
        self.scrollView = findUIScrollView(view: self.view)
            
            self.scrollView?.isPagingEnabled = self.pageEnable
        
        self.scrollView?.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset), options: [.old, .new], context: nil)
        
        self.scroll(position: self.offset.wrappedValue, animated: false)
        super.viewDidAppear(animated)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UIScrollView.contentOffset) {
            if let sv = self.scrollView {
                DispatchQueue.main.async {
                    self.offset.wrappedValue = sv.contentOffset.y
                }
            }
        }
    }
    
    func scroll(position: CGFloat, animated: Bool = true) {
        if let sv = self.scrollView {
            if position != sv.contentOffset.y {
                self.scrollView?.setContentOffset(CGPoint(x: 0, y: position), animated: animated)
            }
        }
    }
    
    func findUIScrollView(view: UIView?) -> UIScrollView? {
        if view?.isKind(of: UIScrollView.self) ?? false {
            return (view as? UIScrollView)
        }
        
        for v in view?.subviews ?? [] {
            if let vc = findUIScrollView(view: v) {
                return vc
            }
        }
        
        return nil
    }
    
    deinit {
        self.scrollView?.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
    }
}
