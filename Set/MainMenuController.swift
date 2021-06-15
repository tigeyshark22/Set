//
//  MainMenuController.swift
//  Set
//
//  Created by Owen Yang on 6/11/21.
//

import UIKit

class MainMenuController: UIViewController {
    
    private var spacing: CGFloat=0
    private var rulesController: UIViewController=UIViewController()
    private var lbController: UIViewController=UIViewController()
    private var settings: UIViewController=UIViewController()
    
    private let setImageView: UIImageView={
        let imageView=UIImageView(image: UIImage(named: "setIcon"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints=false
        return imageView
    }()
    
    private let gameButton: UIButton={
        let gb=UIButton(type: .system)
        let font: UIFont = UIFont(name: "GillSans", size: 22.0)!
        let attrFont=[NSMutableAttributedString.Key.font: font]
        let attrStr=NSMutableAttributedString(string: "Play Game", attributes: attrFont)
        gb.setAttributedTitle(attrStr, for: [])
        gb.translatesAutoresizingMaskIntoConstraints=false
        gb.frame=CGRect(x: 0, y: 0, width: 200, height: 50)
        gb.setTitleColor(.red, for: .normal)
        return gb
    }()
    
    private let rulesButton: UIButton={
        let rb=UIButton(type: .system)
        let font: UIFont = UIFont(name: "GillSans", size: 22.0)!
        let attrFont=[NSMutableAttributedString.Key.font: font]
        let attrStr=NSMutableAttributedString(string: "Rules", attributes: attrFont)
        rb.setAttributedTitle(attrStr, for: [])
        rb.translatesAutoresizingMaskIntoConstraints=false
        rb.frame=CGRect(x: 0, y: 0, width: 200, height: 50)
        rb.setTitleColor(.green, for: .normal)
        rb.addTarget(self, action: #selector(rbPressed), for: .touchUpInside)
        return rb
    }()
    
    @objc private func rbPressed() {
        navigationController?.pushViewController(rulesController, animated: true)
    }
    
    private let leaderButton: UIButton={
        let lb=UIButton(type: .system)
        let font: UIFont = UIFont(name: "GillSans", size: 22.0)!
        let attrFont=[NSMutableAttributedString.Key.font: font]
        let attrStr=NSMutableAttributedString(string: "Leaderboard", attributes: attrFont)
        lb.setAttributedTitle(attrStr, for: [])
        lb.translatesAutoresizingMaskIntoConstraints=false
        lb.frame=CGRect(x: 0, y: 0, width: 200, height: 50)
        lb.setTitleColor(.purple, for: .normal)
        lb.addTarget(self, action: #selector(lbPressed), for: .touchUpInside)
        return lb
    }()
    
    @objc private func lbPressed() {
        navigationController?.pushViewController(lbController, animated: true)
    }
    
    private let settingsButton: UIButton={
        let sb=UIButton(type: .system)
        let font: UIFont = UIFont(name: "GillSans", size: 22.0)!
        let attrFont=[NSMutableAttributedString.Key.font: font]
        let attrStr=NSMutableAttributedString(string: "Settings", attributes: attrFont)
        sb.setAttributedTitle(attrStr, for: [])
        sb.translatesAutoresizingMaskIntoConstraints=false
        sb.frame=CGRect(x: 0, y: 0, width: 200, height: 50)
        sb.setTitleColor(.blue, for: .normal)
        sb.addTarget(self, action: #selector(sbPressed), for: .touchUpInside)
        return sb
    }()
    
    @objc private func sbPressed() {
        navigationController?.pushViewController(settings, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoard:UIStoryboard=UIStoryboard(name: "Main", bundle:nil)
        rulesController=storyBoard.instantiateViewController(withIdentifier: "Rules") as! RulesController
        lbController=storyBoard.instantiateViewController(withIdentifier: "Leaderboard") as! LeaderboardController
        settings=storyBoard.instantiateViewController(withIdentifier: "Settings") as! Settings
        
        title="Main Menu"
        view.backgroundColor = .white
        view.addSubview(setImageView)
        view.addSubview(gameButton)
        view.addSubview(rulesButton)
        view.addSubview(leaderButton)
        view.addSubview(settingsButton)
        
        spacing=CGFloat(view.safeAreaLayoutGuide.layoutFrame.height)/10
        
        setUpSetImage()
        setUpGButton()
        setUpRButton()
        setUpLButton()
        setUpSButton()
    }
    
    private func setUpSetImage() {
        setImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        setImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(spacing)).isActive=true
    }

    private func setUpGButton() {
        gameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        gameButton.topAnchor.constraint(equalTo: setImageView.bottomAnchor, constant: CGFloat(spacing)).isActive=true
    }
    
    private func setUpRButton() {
        rulesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        rulesButton.topAnchor.constraint(equalTo: gameButton.bottomAnchor, constant: CGFloat(spacing)).isActive=true
    }
    
    private func setUpLButton() {
        leaderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        leaderButton.topAnchor.constraint(equalTo: rulesButton.bottomAnchor, constant: CGFloat(spacing)).isActive=true
    }
    
    private func setUpSButton() {
        settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        settingsButton.topAnchor.constraint(equalTo: leaderButton.bottomAnchor, constant: CGFloat(spacing)).isActive=true
    }
}

