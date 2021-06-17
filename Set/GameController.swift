//
//  GameController.swift
//  Set
//
//  Created by Owen Yang on 6/14/21.
//

import UIKit

class GameController: UIViewController, UITextFieldDelegate {
    var numButtons: Int=0
    var deck: Deck=Deck()
    var vspacing: CGFloat=0
    var cardspacing: CGFloat=0
    var hspacing: CGFloat=0
    var keyboardHeight: CGFloat=0
    var buttonList: [UIButton]=[]
    var svList: [UIStackView]=[]
    var timer: GameTimer=GameTimer()
    private var selectedCount: Int=0
    
    private let enterText: UITextView={
        let textView=TextView.init(text2: "Enter your name here:").textView
        textView.backgroundColor = .white
        //textView.isHidden=true
        return textView
    }()
    
    private let inputText: UITextField={
        let textField=UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font=UIFont(name: "GillSans", size: 16.0)!
        //textField.isHidden=true
        textField.addTarget(self, action: #selector(checkText), for: UIControl.Event.editingChanged)
        return textField
    }()
    
    @objc private func checkText() {
        let endInd=(inputText.text?.index(inputText.text!.endIndex, offsetBy: -1))!
        if String(inputText.text![endInd])=="\n" {
        }
        if inputText.text!.count>15 {
            let ind=inputText.text?.index(inputText.text!.startIndex, offsetBy: 15)
            inputText.text!=String(inputText.text![..<ind!])
        }
    }
    
    private let submit: UIButton={
        let btn=UIButton(type: .system)
        let font: UIFont = UIFont(name: "GillSans", size: 20.0)!
        let attrFont=[NSMutableAttributedString.Key.font: font]
        let attrStr=NSMutableAttributedString(string: "Submit", attributes: attrFont)
        btn.setAttributedTitle(attrStr, for: [])
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth=1.0
        btn.layer.borderColor=UIColor.blue.cgColor
        //btn.isHidden=true
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.tintColor = .clear
        btn.addTarget(self, action: #selector(submitClicked), for: .touchUpInside)
        return btn
    }()
    
    @objc private func submitClicked() {
        inputText.resignFirstResponder()
        let name=inputText.text!
        let lb=Leaderboard()
        if lb.times.isEmpty || timer.sec<lb.times.last! {
            lb.writeTime(name: name, time: timer.sec)
        }
        enterText.isHidden=true
        inputText.isHidden=true
        submit.isHidden=true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        vspacing=CGFloat(view.safeAreaLayoutGuide.layoutFrame.height)/12.5
        cardspacing=CGFloat(62)
        hspacing=CGFloat(view.safeAreaLayoutGuide.layoutFrame.width)/10
        
        for i in 0..<21 {
            createButton()
            updatePic(i: i)
        }
        
        for i in 0..<7 {
            createStack(ind: i)
        }
        
        view.addSubview(timer.displayTime)
        setUpTimer()
        setUpEnterText()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        inputText.delegate=self
    }
    
    @objc private  func keyboardWillShow(sender: NSNotification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
        self.view.frame.origin.y = -keyboardHeight // Move view 150 points upward
    }

    @objc private func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    private func setUpEnterText() {
        let enterStack=UIStackView(arrangedSubviews: [enterText, inputText, submit])
        
        enterStack.distribution = .fillEqually
        view.addSubview(enterStack)
        
        inputText.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive=true
        submit.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive=true
        enterStack.translatesAutoresizingMaskIntoConstraints=false
        enterStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive=true
        enterStack.widthAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1.0).isActive=true
        enterStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7*cardspacing+vspacing).isActive=true
        enterStack.spacing = UIStackView.spacingUseSystem
    }
    
    private func setUpTimer() {
        timer.displayTime.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive=true
        timer.displayTime.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: vspacing/3).isActive=true
    }
    
    private func updateBoard() {
        for i in 0..<21 {
            updatePic(i: i)
        }
    }
    
    private func updateCard(ind: Int) {
        deck.current[ind].selected = !deck.current[ind].selected
        let temp=deck.current[ind].selected
        if temp {
            selectedCount+=1
        }
        else {
            selectedCount-=1
        }
    }
    
    private func createButton() {
        let btn=UIButton(type: .system)
        btn.frame=CGRect(x: 0, y: 0, width: 75, height: 52)
        btn.backgroundColor = .none
        btn.setBackgroundImage(UIImage(named: "blank"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.tintColor = .clear
        btn.layer.cornerRadius = 8.0
        btn.layer.borderColor = UIColor.red.cgColor
        btn.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        buttonList.append(btn)
    }
    
    private func updatePic(i: Int) {
        if i<deck.current.count {
            buttonList[i].isHidden=false
            buttonList[i].setBackgroundImage(UIImage(named: deck.current[i].getPic()), for: .normal)
        }
        else {
            buttonList[i].isHidden=true
        }
    }
    
    private func createStack(ind: Int) {
        let sv=UIStackView(arrangedSubviews: [buttonList[3*ind],buttonList[3*ind+1],buttonList[3*ind+2]])
        
        sv.translatesAutoresizingMaskIntoConstraints=false
        sv.distribution = .fillEqually
        view.addSubview(sv)
        svList.append(sv)
        
        sv.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        sv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(ind)*cardspacing+vspacing).isActive=true
        sv.spacing=hspacing
    }
    
    @objc private func clicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        var found=false
        var i=0
        while !found {
            if sender==buttonList[i] {
                updateCard(ind: i)
                found=true
            }
            i+=1
        }
        updateIfSet()
        updateBorder(sender: sender)
    }
    
    private func updateIfSet() {
        if selectedCount==3 {
            //var tempSet=deck.getCardSelected()
            deck.changeSelected()
            for i in buttonList {
                i.isSelected=false
                updateBorder(sender: i)
            }
            updateBoard()
            selectedCount=0
            if deck.endGame() {
                timer.timer.invalidate()
                timer.displayTime.text="Game over! Your time is \(timer.getTime(time: timer.sec))"
                for i in buttonList {
                    i.isEnabled=false
                }
                enterText.isHidden=false
                inputText.isHidden=false
                submit.isHidden=false
            }
        }
    }
    
    private func updateBorder(sender: UIButton) {
        if sender.isSelected {
            sender.layer.borderWidth = 2.0
        }
        else {
            sender.layer.borderWidth = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
