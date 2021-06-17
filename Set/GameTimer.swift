//
//  GameTimer.swift
//  Set
//
//  Created by Owen Yang on 6/15/21.
//

import Foundation
import UIKit

class GameTimer {
    var sec: Int
    var displayTime: UITextView
    var timer: Timer=Timer()
    
    init() {
        sec=0
        displayTime=TextView.init(text2: "0:00").textView
        let font: UIFont=UIFont(name: "GillSans", size: 22.0)!
        displayTime.font=font
        timer=Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(blah), userInfo: nil, repeats: true)
        
    }
    
    @objc private func blah() {
        sec+=1
        displayTime.text=getTime(time: sec)
    }
    
    func getTime(time: Int) -> String {
        let min=time/60
        let sec=time%60
        if sec<10 {
            return "\(min):0\(sec)"
        }
        return "\(min):\(sec)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
