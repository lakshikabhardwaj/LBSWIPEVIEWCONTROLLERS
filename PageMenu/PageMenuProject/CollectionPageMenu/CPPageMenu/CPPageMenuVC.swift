//
//  CPPageMenuVC.swift
//  CollectionPageMenu
//
//  Created by lakshika bhardwaj on 20/04/16.
//  Copyright © 2016 Kellton Tech. All rights reserved.
//

import UIKit

var ktabSelectedColor: UIColor = UIColor.gray
var ktabDefaultColor :UIColor = UIColor.green
var ktabTextColorDefault :UIColor = UIColor.white
var ktabTextColorSelected :UIColor = UIColor.black

class CPPageMenuVC:UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var pageCollectionView: UICollectionView!
    
    @IBOutlet weak var tabCollectionView: UICollectionView!
    
    var underLineImage: UIImageView = UIImageView()
    
    var pageArray : [PageModal] = []
    
    var selectedIndex = 0
    
    let collectionCell = "PageCell"
    let tabCell = "TabCell"
    
    var isSelectedOnTap :Bool = false
    var isDeaccelerating :Bool = false
    
    //tab properties ..
    
    var tabWidth : CGFloat = 100
    var tabMargin : CGFloat = 10
    var tabHeight : CGFloat = 100 {
        
        didSet {
            tabCollectionView.frame.size.height = tabHeight
        }
        
    }
    var tabSelectedColor: UIColor  = ktabSelectedColor {
        didSet {
            ktabSelectedColor = tabSelectedColor
        }
    }
    var tabDefaultColor :UIColor = ktabDefaultColor {
        didSet {
            ktabDefaultColor = tabDefaultColor
        }
    }
    
    var tabTextColorDefault  :UIColor = ktabTextColorDefault {
        didSet {
            ktabSelectedColor = tabDefaultColor
        }
    }
    var tabTextColorSelected :UIColor = ktabTextColorSelected {
        didSet {
            ktabSelectedColor = tabDefaultColor
        }
    }
    
    
    //pageView Prop[erties
    
    //  var pageViewControllersArray  :[UIViewController] = []
    
    var underLineColorForSelectedTab = UIColor.black
    var underLineHeight :CGFloat = 2.5
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addUnderLineForTab()
        self.navigationController?.isNavigationBarHidden = true
        setCollectionDataSource()
        regitserNib()
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:-  Nib and Datasource
    func setCollectionDataSource() {
        tabCollectionView.backgroundColor = ktabDefaultColor
        tabCollectionView.dataSource = self
        pageCollectionView.dataSource = self
    }
    
    func regitserNib() {
        
        let nib = UINib(nibName: "CPPageCell", bundle: nil)
        pageCollectionView?.register(nib, forCellWithReuseIdentifier: collectionCell)
        let tabNib = UINib(nibName: "CPTabCell", bundle: nil)
        tabCollectionView?.register(tabNib, forCellWithReuseIdentifier: tabCell)
    }
    
    func  addUnderLineForTab() {
        
        underLineImage.frame.origin.x = tabCollectionView!.frame.origin.x
        underLineImage.frame.origin.y = tabCollectionView!.frame.origin.y + (tabCollectionView?.frame.size.height)!  - underLineHeight
        underLineImage.frame.size.height = underLineHeight
        underLineImage.frame.size.width = tabWidth
        underLineImage.backgroundColor  = underLineColorForSelectedTab
        self.view.addSubview(underLineImage)
    }
    
    
    //MARK: -  Collection View Datasource/Delegates
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return pageArray.count
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    //3
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == tabCollectionView) {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabCell, for: indexPath) as! CPTabCell
            
            cell.tabTitle.text = pageArray[indexPath.section].pageTitle
            if selectedIndex == indexPath.section {
                cell.shouldSetCellSelected(true)
            }
                
            else {
                cell.shouldSetCellSelected(false)
            }
            // Configure the cell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath) as! CPPageCell
        // let pageVC = pageViewControllersArray[indexPath.section]
        let pageVC = pageArray[indexPath.section].pageVC
        
        self.addChildViewController(pageVC)
        pageVC.view.frame = cell.contentView.frame
        cell.pageView .addSubview(pageVC.view)
        pageVC.didMove(toParentViewController: self)
        
        
        // Configure the cell
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == tabCollectionView) {
            isSelectedOnTap = true
            changeSelectedIndex(indexPath.section)
            pageCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
    }
    
    //size page collection view cell
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        if (collectionView == pageCollectionView)  {
            return CGSize(width: collectionView.frame.size.width,height: collectionView.frame.size.height)
        }
            
        else {
            
            var calucatedWidth = tabWidth
            
            if( tabCollectionView.frame.width / CGFloat(pageArray.count)  > calucatedWidth) {
                calucatedWidth = tabCollectionView.frame.width / CGFloat(pageArray.count)
            }
            
            let tabText :String = pageArray[indexPath.section].pageTitle
            let textSize   = (tabText as NSString).size(attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 17.0)])
            
            if (calucatedWidth < textSize.width) {
                calucatedWidth = textSize.width + tabMargin + tabMargin
            }
            return CGSize(width: calucatedWidth,height: collectionView.frame.size.height)
        }
        
    }
    
       //MARK: -  Scroll View Delegates
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if( scrollView == pageCollectionView ) {
            let currentIndex =  pageCollectionView.indexPathForItem(at: CGPoint(x: pageCollectionView.center.x + pageCollectionView.contentOffset.x,y: pageCollectionView.center.y + pageCollectionView.contentOffset.y))
            if !isSelectedOnTap {
                changeSelectedIndex(currentIndex!.section)
            }
            print("Center:\(currentIndex?.section)")
            
            if  let currentCell = tabCollectionView.cellForItem(at: IndexPath(row: 0, section: selectedIndex)) as? CPTabCell {
                
                underLineImage.frame.origin.x = (tabWidth/pageCollectionView!.frame.size.width) * pageCollectionView.contentOffset.x - tabCollectionView.contentOffset.x
                
                underLineImage.frame.size.width = currentCell.frame.size.width
            }
            
        }
        
        if(scrollView == tabCollectionView) {
            
            if  let currentCell = tabCollectionView.cellForItem(at: IndexPath(row: 0, section: selectedIndex)) as? CPTabCell {
                
                underLineImage.frame.origin.x = currentCell.frame.origin.x - tabCollectionView.contentOffset.x
                underLineImage.frame.size.width = currentCell.frame.size.width
            }
            
        }
        
    }
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if( scrollView == pageCollectionView) {
            isSelectedOnTap = false
            isDeaccelerating = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if( scrollView == pageCollectionView) {
            
            isDeaccelerating = false
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        if  let currentCell = tabCollectionView.cellForItem(at: IndexPath(row: 0, section: selectedIndex)) as? CPTabCell  {
            
            if !isDeaccelerating {
                underLineImage.frame.origin.x = currentCell.frame.origin.x - tabCollectionView.contentOffset.x
                underLineImage.frame.size.width = currentCell.frame.size.width}
            
        }
        
    }
    
       //MARK: -  Selection Methods
    
    func changeSelectedIndex(_ index :Int) {
        
        let preCell = tabCollectionView.cellForItem(at: IndexPath(row: 0, section: selectedIndex)) as? CPTabCell
        preCell?.shouldSetCellSelected(false)
        let currentCell = tabCollectionView.cellForItem(at: IndexPath(row: 0, section: index)) as? CPTabCell
        currentCell?.shouldSetCellSelected(true)
        selectedIndex = index
        tabCollectionView.scrollToItem(at: IndexPath(row: 0, section: selectedIndex), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        
    }
    
}

class PageModal: NSObject {
    
    var pageTitle :String
    var pageVC :UIViewController
    
    init(pageTitle :String,pageVC :UIViewController) {
        
        self.pageTitle = pageTitle
        self.pageVC = pageVC
    }
    
}
