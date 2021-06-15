//
//  RulesP2.swift
//  Set
//
//  Created by Owen Yang on 6/12/21.
//

import UIKit

class RulesP2: UICollectionViewCell {
    
    var vspacing: CGFloat=0
    var hspacing: CGFloat=0
    
    private let text1: UITextView={
        let textView=TextView.init(text2: "For example, the below three cards form a set-we can check that all four characteristics are either all the same or all different.").textView
        return textView
    }()
    
    private let set1ImageView: UIImageView={
        let imageView=ImageView.init(picName: "set37").imageView
        return imageView
    }()
    
    private let set2ImageView: UIImageView={
        let imageView=ImageView.init(picName: "set63").imageView
        return imageView
    }()
    
    private let set3ImageView: UIImageView={
        let imageView=ImageView.init(picName: "set11").imageView
        return imageView
    }()
    
    private let text2: UITextView={
        let textView=TextView.init(text2: "On the other hand, the below three cards do NOT form a set because two are diamonds and one is an oval.").textView
        return textView
    }()
    
    private let set4ImageView: UIImageView={
        let imageView=ImageView.init(picName: "set45").imageView
        return imageView
    }()
    
    private let set5ImageView: UIImageView={
        let imageView=ImageView.init(picName: "set55").imageView
        return imageView
    }()
    
    private let set6ImageView: UIImageView={
        let imageView=ImageView.init(picName: "set14").imageView
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(text1)
        addSubview(text2)
        
        vspacing=CGFloat(safeAreaLayoutGuide.layoutFrame.height)/30
        hspacing=CGFloat(safeAreaLayoutGuide.layoutFrame.width)/6
        
        setUpText1()
        setUpSet1()
        setUpText2()
        setUpSet2()
    }
    
    private func setUpText1() {
        text1.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive=true
        text1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        text1.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CGFloat(vspacing)).isActive=true
    }
    
    private func setUpSet1() {
        let set1stack=UIStackView(arrangedSubviews: [set1ImageView, set2ImageView, set3ImageView])
        set1stack.translatesAutoresizingMaskIntoConstraints=false
        set1stack.distribution = .fillEqually
        addSubview(set1stack)
        set1stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        set1stack.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: CGFloat(vspacing)).isActive=true
        set1stack.spacing = UIStackView.spacingUseSystem
    }
    
    private func setUpText2() {
        text2.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive=true
        text2.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        text2.topAnchor.constraint(equalTo: set2ImageView.bottomAnchor, constant: CGFloat(vspacing)).isActive=true
    }
    
    private func setUpSet2() {
        let set2stack=UIStackView(arrangedSubviews: [set4ImageView, set5ImageView, set6ImageView])
        set2stack.translatesAutoresizingMaskIntoConstraints=false
        set2stack.distribution = .fillEqually
        addSubview(set2stack)
        set2stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        set2stack.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: CGFloat(vspacing)).isActive=true
        set2stack.spacing = UIStackView.spacingUseSystem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
