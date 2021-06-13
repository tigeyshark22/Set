//
//  RulesP1.swift
//  Set
//
//  Created by Owen Yang on 6/12/21.
//

import UIKit

class RulesP1: UICollectionViewCell {
    
    var spacing: CGFloat=0
    
    private let text1: UITextView={
        let textView=TextView.init(text2: "Welcome! Set is a game that was developed in 1984,\n in which the objective is to find sets,\n or three-card combinations with certain properties,\n as fast as possible.").textView
        return textView
    }()
    
    private let text2: UITextView={
        let textView=TextView.init(text2: "This game is played with a deck of 81 cards.\n Each card has a unique combination of\n four characteristics:\n color, shape, shade, and number.").textView
        return textView
    }()
    
    private let text3: UITextView={
        let textView=TextView.init(text2: "The possible colors are green, red, and purple.\n The possible shapes are diamond, oval, and squiggle.\n The possible shades are solid, clear, and striped.\n The possible numbers are one, two, and three.").textView
        return textView
    }()
    
    private let text4: UITextView={
        let textView=TextView.init(text2: "Three cards form a set if and only if for all\n of the four characteristics, either all three\n have the same attribute or all three have\n different attributes.").textView
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(text1)
        addSubview(text2)
        addSubview(text3)
        addSubview(text4)
        
        spacing=CGFloat(safeAreaLayoutGuide.layoutFrame.height)/30
        
        setUpText1()
        setUpText2()
        setUpText3()
        setUpText4()
    }
    
    private func setUpText1() {
        text1.frame=CGRect(x: 0, y: 0, width: safeAreaLayoutGuide.layoutFrame.width, height: 100)
        text1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        text1.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CGFloat(spacing)).isActive=true
    }
    
    private func setUpText2() {
        text2.frame=CGRect(x: 0, y: 0, width: safeAreaLayoutGuide.layoutFrame.width, height: 100)
        text2.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        text2.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: CGFloat(spacing)).isActive=true
    }
    
    private func setUpText3() {
        text3.frame=CGRect(x: 0, y: 0, width: safeAreaLayoutGuide.layoutFrame.width, height: 100)
        text3.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        text3.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: CGFloat(spacing)).isActive=true
    }
    
    private func setUpText4() {
        text4.frame=CGRect(x: 0, y: 0, width: safeAreaLayoutGuide.layoutFrame.width, height: 100)
        text4.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        text4.topAnchor.constraint(equalTo: text3.bottomAnchor, constant: CGFloat(spacing)).isActive=true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
