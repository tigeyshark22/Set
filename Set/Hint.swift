//
//  Hint.swift
//  Set
//
//  Created by Owen Yang on 6/16/21.
//

import UIKit

struct Hint {
    var c1: UIImageView=UIImageView()
    var c2: UIImageView=UIImageView()
    var c3: UIImageView=UIImageView()
    var hintView: UIStackView=UIStackView()
    
    init(c1: Card, c2: Card, c3: Card) {
        self.c1=cardToPic(card: c1)
        self.c1.layer.borderColor=UIColor.blue.cgColor
        self.c1.layer.cornerRadius=8.0
        self.c2=cardToPic(card: c2)
        self.c2.layer.borderColor=UIColor.blue.cgColor
        self.c2.layer.cornerRadius=8.0
        self.c3=cardToPic(card: c3)
        self.c3.layer.borderColor=UIColor.blue.cgColor
        self.c3.layer.cornerRadius=8.0
        hintView=UIStackView()
        hintView=UIStackView(arrangedSubviews: [self.c1, self.c2, self.c3])
        self.c1.isHidden=true
        self.c2.isHidden=true
        self.c3.isHidden=true
        hintView.translatesAutoresizingMaskIntoConstraints=false
        hintView.distribution = .fillEqually
    }
    
    func cardToPic(card: Card) -> UIImageView {
        return UIImageView(image: UIImage(named: card.getPic()))
    }
}
