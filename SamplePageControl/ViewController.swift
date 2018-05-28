//
//  ViewController.swift
//  SamplePageControl
//
//  Created by Hitesh on 1/7/17.
//  Copyright © 2017 spaceo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrMain: UIScrollView!
    
    let arrImages = ["1.jpeg", "2.jpeg", "3.jpeg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewDidLayoutSubviews() {
        self.loadScrollView()
    }
    
    func loadScrollView() {
        let pageCount : CGFloat = CGFloat(arrImages.count)
        
        scrMain.backgroundColor = UIColor.clear
        scrMain.delegate = self
        scrMain.isPagingEnabled = true
        scrMain.contentSize = CGSize(width: scrMain.frame.size.width * pageCount, height: scrMain.frame.size.height)
        scrMain.showsHorizontalScrollIndicator = false
        
        pageControl.numberOfPages = Int(pageCount)
        pageControl.addTarget(self, action: #selector(self.pageChanged), for: .valueChanged)
        
        for i in 0..<Int(pageCount) {
            print(self.scrMain.frame.size.width)
            let image = UIImageView(frame: CGRect(x: self.scrMain.frame.size.width * CGFloat(i), y: 0, width: self.scrMain.frame.size.width, height: self.scrMain.frame.size.height))
            image.image = UIImage(named: arrImages[i])!
            image.contentMode = UIViewContentMode.scaleAspectFit
            self.scrMain.addSubview(image)
        }
    }
    
    
    //MARK: UIScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let viewWidth: CGFloat = scrollView.frame.size.width
        // content offset - tells by how much the scroll view has scrolled.
        let pageNumber = floor((scrollView.contentOffset.x - viewWidth / 50) / viewWidth) + 1
        pageControl.currentPage = Int(pageNumber)
    }
    
    
    //MARK: Page tap action
    func pageChanged() {
        let pageNumber = pageControl.currentPage
        var frame = scrMain.frame
        frame.origin.x = frame.size.width * CGFloat(pageNumber)
        frame.origin.y = 0
        scrMain.scrollRectToVisible(frame, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

