//
//  GameController.swift
//  Set
//
//  Created by Owen Yang on 6/14/21.
//

import UIKit

class GameController: UIViewController, UITextFieldDelegate {
    private var deck: Deck=Deck()
    private var vspacing: CGFloat=0
    private var cardspacing: CGFloat=0
    private var hspacing: CGFloat=0
    private var keyboardHeight: CGFloat=0
    var buttonList: [UIButton]=[]
    var svList: [UIStackView]=[]
    private var layoutCon1: NSLayoutConstraint=NSLayoutConstraint()
    private var layoutCon2: NSLayoutConstraint=NSLayoutConstraint()
    private var timer: GameTimer=GameTimer()
    private var numReveal: Int=0
    private var selectedCount: Int=0
    private var hint: Hint=Hint(c1: Card(number: 0,color: 0,shape: 0,shade: 0,selected: false), c2: Card(number: 0,color: 0,shape: 0,shade: 0,selected: false), c3: Card(number: 0,color: 0,shape: 0,shade: 0,selected: false))
    private var hintsUsed=true
    private var enterStack: UIStackView=UIStackView()
    
    private let enterText: UITextView={
        let textView=TextView.init(text2: "Enter your name here:").textView
        textView.backgroundColor = .white
        textView.isHidden=true
        return textView
    }()
    
    private let inputText: UITextField={
        let textField=UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font=UIFont(name: "GillSans", size: 16.0)!
        textField.isHidden=true
        textField.addTarget(self, action: #selector(checkText), for: UIControl.Event.editingChanged)
        return textField
    }()
    
    @objc private func checkText() {
        if inputText.text!.count>15 {
            let ind=inputText.text?.index(inputText.text!.startIndex, offsetBy: 15)
            inputText.text!=String(inputText.text![..<ind!])
        }
    }
    
    private let hintBtn: UIButton={
        let btn=UIButton(type: .system)
        let font: UIFont = UIFont(name: "GillSans", size: 20.0)!
        let attrFont=[NSMutableAttributedString.Key.font: font]
        let attrStr=NSMutableAttributedString(string: "Hint", attributes: attrFont)
        btn.setAttributedTitle(attrStr, for: [])
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.tintColor = .clear
        btn.addTarget(self, action: #selector(hintClicked), for: .touchUpInside)
        return btn
    }()
    
    private let submit: UIButton={
        let btn=UIButton(type: .system)
        let font: UIFont = UIFont(name: "GillSans", size: 20.0)!
        let attrFont=[NSMutableAttributedString.Key.font: font]
        let attrStr=NSMutableAttributedString(string: "Submit", attributes: attrFont)
        btn.setAttributedTitle(attrStr, for: [])
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth=1.0
        btn.layer.borderColor=UIColor.blue.cgColor
        btn.isHidden=true
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.tintColor = .clear
        btn.addTarget(self, action: #selector(submitClicked), for: .touchUpInside)
        return btn
    }()
    
    private let playAgain: UIButton={
        let btn=UIButton(type: .system)
        let font: UIFont = UIFont(name: "GillSans", size: 20.0)!
        let attrFont=[NSMutableAttributedString.Key.font: font]
        let attrStr=NSMutableAttributedString(string: "Play Again", attributes: attrFont)
        btn.setAttributedTitle(attrStr, for: [])
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth=1.0
        btn.layer.borderColor=UIColor.blue.cgColor
        btn.isHidden=true
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.tintColor = .clear
        btn.addTarget(self, action: #selector(playClicked), for: .touchUpInside)
        btn.contentEdgeInsets=UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return btn
    }()
    
    @objc private func hintClicked() {
        if numReveal<3 {
            numReveal+=1
        }
        revealHint()
    }
    
    @objc private func submitClicked() {
        inputText.resignFirstResponder()
        let name=inputText.text!
        var lb: Leaderboard
        if hintsUsed {
            lb=Leaderboard(fileName: "setLBHints")
        } else {
            lb=Leaderboard(fileName: "setLBNoHints")
        }
        lb.writeTime(name: name, time: timer.sec)
        enterText.isHidden=true
        inputText.isHidden=true
        submit.isHidden=true
        playAgain.isHidden=false
    }
    
    @objc private func playClicked() {
        deck=Deck()
        timer.displayTime.isHidden=true
        timer=GameTimer()
        timer.start()
        setUpTimerStack()
        playAgain.isHidden=true
        for i in buttonList {
            i.isEnabled=true
        }
        if Settings.hint {
            hintBtn.isEnabled=true
            hintBtn.setTitleColor(.black, for: .normal)
        } else {
            hintBtn.isEnabled=false
            hintBtn.setTitleColor(.white, for: .normal)
        }
        updateBoard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        vspacing=CGFloat(view.safeAreaLayoutGuide.layoutFrame.height)/10
        cardspacing=CGFloat(62)
        hspacing=CGFloat(view.safeAreaLayoutGuide.layoutFrame.width)/10
        
        for i in 0..<21 {
            createButton()
            updatePic(i: i)
        }
        
        for i in 0..<7 {
            createStack(ind: i)
        }
        
        view.addSubview(playAgain)
        view.addSubview(hint.hintView)
        setUpTimerStack()
        setUpEnterText()
        setUpPlayAgain()
        setUpHintView()
        updateHint()
        timer.start()
        
        layoutCon1=enterStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7*cardspacing+vspacing)
        layoutCon1.isActive=true
        
        if !Settings.hint {
            hintBtn.isEnabled=false
            hintBtn.setTitleColor(.white, for: .normal)
            hintsUsed=false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        inputText.delegate=self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        inputText.resignFirstResponder()
    }
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.size.height
        }
        layoutCon2=enterStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7*cardspacing+vspacing-keyboardHeight)
        layoutCon1.isActive=false
        layoutCon2.isActive=true
    }

    @objc private func keyboardWillHide(sender: NSNotification) {
        layoutCon2.isActive=false
        layoutCon1.isActive=true
    }
    
    private func setUpEnterText() {
        enterStack=UIStackView(arrangedSubviews: [enterText, inputText, submit])
        
        enterStack.distribution = .fillEqually
        view.addSubview(enterStack)
        
        inputText.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive=true
        submit.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive=true
        enterStack.translatesAutoresizingMaskIntoConstraints=false
        enterStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive=true
        enterStack.widthAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1.0).isActive=true
        enterStack.spacing = UIStackView.spacingUseSystem
    }
    
    private func setUpTimerStack() {
        let timerStack=UIStackView(arrangedSubviews: [UIImageView(image: UIImage(named: "blank")), timer.displayTime, hintBtn])
        timerStack.translatesAutoresizingMaskIntoConstraints=false
        timerStack.distribution = .fillEqually
        view.addSubview(timerStack)
        timerStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive=true
        timerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: vspacing/3).isActive=true
        timerStack.spacing=hspacing
    }
    
    private func setUpPlayAgain() {
        playAgain.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7*cardspacing+vspacing).isActive=true
        playAgain.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive=true
    }
    
    private func setUpHintView() {
        hint.hintView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive=true
        hint.hintView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7*cardspacing+vspacing).isActive=true
        hint.hintView.spacing=hspacing
    }
    
    private func revealHint() {
        if numReveal==0 {
            hint.c1.isHidden=true
            hint.c2.isHidden=true
            hint.c3.isHidden=true
        }
        if numReveal==1 {
            hint.c1.isHidden=false
        }
        if numReveal==2 {
            hint.c2.isHidden=false
        }
        if numReveal==3 {
            hint.c3.isHidden=false
        }
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
        numReveal=0
        revealHint()
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
            updateHint()
            selectedCount=0
            if deck.endGame() {
                timer.timer.invalidate()
                timer.displayTime.text="Game over! Your time is \(timer.getTime(time: timer.sec))"
                for i in buttonList {
                    i.isEnabled=false
                }
                hint.hintView.isHidden=true
                hintBtn.isEnabled=false
                enterText.isHidden=false
                inputText.isHidden=false
                submit.isHidden=false
            }
        }
    }
    
    private func updateHint() {
        if deck.setList.count>0 {
            hint.c1.image=UIImage(named: deck.current[deck.setList[0][0]].getPic())
            hint.c1.layer.borderWidth=2.0
            hint.c2.image=UIImage(named: deck.current[deck.setList[0][1]].getPic())
            hint.c2.layer.borderWidth=2.0
            hint.c3.image=UIImage(named: deck.current[deck.setList[0][2]].getPic())
            hint.c3.layer.borderWidth=2.0
        } else {
            hint.c1.image=UIImage(named: "blank")
            hint.c1.layer.borderWidth=0.0
            hint.c2.image=UIImage(named: "blank")
            hint.c2.layer.borderWidth=0.0
            hint.c3.image=UIImage(named: "blank")
            hint.c3.layer.borderWidth=0.0
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
