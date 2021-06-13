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
        let textView=TextView.init(text2: "In the actual game, normally the board\n will contain 12 cards from the deck.\n Once cards are selected from a set,\n they are discarded. Then, three new cards\n are dealt to replace the ones that\n formed a set. The game ends when there are\n no more cards in the deck and\n there are no more sets on the board.").textView
        return textView
    }()
    
    private let text2: UITextView={
        let textView=TextView.init(text2: "Rarely, if there are no sets on the 12 card board,\n an extra 3 cards will be dealt\n temporarily to ensure that there is a set\n on the board, making it\n 15 cards. Even more rarely, 3 more extra\n cards will be dealt if that board\n also contains no sets.").textView
        return textView
    }()
    
    private let text3: UITextView={
        let textView=TextView.init(text2: "That's all the rules to the game! You can\n turn hints on or off in the settings.\n Clicking the hint button will show one card\n from one possible set on the board.\n There are separate leaderboards for\n using hints or no hints.").textView
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
