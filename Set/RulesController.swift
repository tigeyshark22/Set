//
//  RulesController.swift
//  Set
//
//  Created by Owen Yang on 6/12/21.
//

import SwiftUI

class RulesController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let pageControl: UIPageControl={
        let pc=UIPageControl()
        pc.currentPage=0
        pc.numberOfPages=3
        pc.currentPageIndicatorTintColor = .darkGray
        pc.pageIndicatorTintColor = .lightGray
        pc.isUserInteractionEnabled=false
        return pc
    }()
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x=targetContentOffset.pointee.x
        pageControl.currentPage=Int (x/view.frame.width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title="Rules"
        view.addSubview(pageControl)
        setUpPC()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(RulesP1.self, forCellWithReuseIdentifier: "cellId1")
        collectionView?.register(RulesP2.self, forCellWithReuseIdentifier: "cellId2")
        collectionView?.register(RulesP3.self, forCellWithReuseIdentifier: "cellId3")
        collectionView?.isPagingEnabled=true
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
    
    private func setUpPC() {
        pageControl.translatesAutoresizingMaskIntoConstraints=false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive=true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell=UICollectionViewCell()
        if indexPath.item==0 {
            cell=collectionView.dequeueReusableCell(withReuseIdentifier: "cellId1", for: indexPath)
        }
        if indexPath.item==1 {
            cell=collectionView.dequeueReusableCell(withReuseIdentifier: "cellId2", for: indexPath)
        }
        if indexPath.item==2 {
            cell=collectionView.dequeueReusableCell(withReuseIdentifier: "cellId3", for: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
