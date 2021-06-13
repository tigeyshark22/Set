//
//  TextView.swift
//  Set
//
//  Created by Owen Yang on 6/12/21.
//

import UIKit

struct TextView {
    var textView: UITextView
    let font: UIFont = UIFont(name: "GillSans", size: 16.0)!
    
    init(text2: String) {
        textView=UITextView()
        textView.isScrollEnabled=false
        textView.isEditable=false
        textView.translatesAutoresizingMaskIntoConstraints=false
        textView.text=text2
        textView.font=font
        textView.textAlignment = .center
    }
}
