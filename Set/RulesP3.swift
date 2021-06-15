//
//  RulesP3.swift
//  Set
//
//  Created by Owen Yang on 6/13/21.
//

import UIKit

class RulesP3: UICollectionViewCell {
    
    var spacing: CGFloat=0
    
    private let text1: UITextView={
        let textView=TextView.init(text2: "In the actual game, normally the board will contain 12 cards from the deck. Once cards are selected from a set, they are discarded. Then, three new cards are dealt to replace the ones that formed a set. The game ends when there are no more cards in the deck and there are no more sets on the board.").textView
        return textView
    }()
    
    private let text2: UITextView={
        let textView=TextView.init(text2: "Rarely, if there are no sets on the 12 card board, an extra 3 cards will be dealt temporarily to ensure that there is a set on the board, making it 15 cards. Even more rarely, 3 more extra cards will be dealt if that board also contains no sets.").textView
        return textView
    }()
    
    private let text3: UITextView={
        let textView=TextView.init(text2: "That's all the rules to the game! You can turn hints on or off in the settings. Clicking the hint button will show one card from one possible set on the board. There are separate leaderboards for using hints or no hints.").textView
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(text1)
        addSubview(text2)
        addSubview(text3)
        
        spacing=CGFloat(safeAreaLayoutGuide.layoutFrame.height)/30
        
        setUpText1()
        setUpText2()
        setUpText3()
    }
    
    private func setUpText1() {
        text1.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive=true
        text1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        text1.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CGFloat(spacing)).isActive=true
    }
    
    private func setUpText2() {
        text2.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive=true
        text2.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        text2.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: CGFloat(spacing)).isActive=true
    }
    
    private func setUpText3() {
        text3.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive=true
        text3.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        text3.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: CGFloat(spacing)).isActive=true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
