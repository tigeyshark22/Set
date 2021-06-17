//
//  LeaderboardHint.swift
//  Set
//
//  Created by Owen Yang on 6/13/21.
//

import UIKit

class LeaderboardHint: UICollectionViewCell {
    
    var vspacing: CGFloat=0
    
    let titleLabel: UIStackView={
        let text1=TextView.init(text2: "").textView
        let text2=TextView.init(text2: "Hints").textView
        text2.textColor = .blue
        text2.font=UIFont(name: "GillSans", size: 22.0)!
        let text3=TextView.init(text2: "").textView
        let textStack=UIStackView(arrangedSubviews: [text1, text2, text3])
        textStack.translatesAutoresizingMaskIntoConstraints=false
        textStack.distribution = .fillEqually
        return textStack
    }()
    
    private let captionLabel: UIStackView={
        let text1=TextView.init(text2: "Place").textView
        let text2=TextView.init(text2: "Name").textView
        let text3=TextView.init(text2: "Time").textView
        let textStack=UIStackView(arrangedSubviews: [text1, text2, text3])
        textStack.translatesAutoresizingMaskIntoConstraints=false
        textStack.distribution = .fillEqually
        return textStack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        overrideUserInterfaceStyle = .light
        vspacing=25//CGFloat(safeAreaLayoutGuide.layoutFrame.height)/30
        translatesAutoresizingMaskIntoConstraints=false
        addSubview(titleLabel)
        addSubview(captionLabel)
        setUpTitle()
        setUpCaption()
        /* // testing purposes
        lb.writeTime(name: "verylongnamelmao", time: 69)
        lb.writeTime(name: "tigey", time: 56)
        lb.writeTime(name: "bruh", time: 420)
        */
        for i in 0..<10 {
            addLBRow(ind: i)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTitle() {
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        titleLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive=true
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: vspacing).isActive=true
    }
    
    private func setUpCaption() {
        captionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        captionLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive=true
        captionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: vspacing).isActive=true
    }
    
    private func getTime(time: Int) -> String {
        let min=time/60
        let sec=time%60
        if sec<10 {
            return "\(min):0\(sec)"
        }
        return "\(min):\(sec)"
    }
    
    private func addLBRow(ind: Int) {
        let lb=Leaderboard()
        var name=""
        var time=0
        var textStack=UIStackView()
        if ind<lb.names.count {
            name=lb.names[ind]
            time=lb.times[ind]
            let text1v=TextView.init(text2: "\(ind+1)").textView
            let text2v=TextView.init(text2: name).textView
            let text3v=TextView.init(text2: getTime(time: time)).textView
            textStack=setUpText(view1: text1v, view2: text2v, view3: text3v)
            addSubview(textStack)
        }
        else {
            let text1v=TextView.init(text2: "\(ind+1)").textView
            let text2v=TextView.init(text2: "").textView
            let text3v=TextView.init(text2: "").textView
            textStack=setUpText(view1: text1v, view2: text2v, view3: text3v)
            addSubview(textStack)
        }
        textStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        textStack.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive=true
        textStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CGFloat(ind+5)*vspacing).isActive=true
    }
    
    private func setUpText(view1: UITextView, view2: UITextView, view3: UITextView) -> UIStackView {
        let textStack=UIStackView(arrangedSubviews: [view1, view2, view3])
        textStack.translatesAutoresizingMaskIntoConstraints=false
        textStack.distribution = .fillEqually
        return textStack
    }
}
