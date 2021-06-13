//
//  Settings.swift
//  Set
//
//  Created by Owen Yang on 6/13/21.
//

import UIKit

class Settings: UIViewController {
    
    static var hint: Bool=false
    
    let toggle: UISwitch={
        let tg=UISwitch()
        tg.translatesAutoresizingMaskIntoConstraints=false
        tg.addTarget(self, action: #selector(hit), for: .touchUpInside)
        return tg
    }()
    
    @objc func hit() {
        Settings.hint = !Settings.hint
    }
    
    private let text1: UITextView={
        let textView=TextView.init(text2: "Hints").textView
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title="Settings"
        view.addSubview(toggle)
        view.addSubview(text1)
        
        setUpToggle()
        setUpText1()
    }
    
    private func setUpToggle() {
        toggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive=true
        toggle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive=true
    }
    
    private func setUpText1() {
        text1.frame=CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width/2, height: 100)
        text1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive=true
        text1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive=true
    }
}
