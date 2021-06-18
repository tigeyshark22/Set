//
//  Settings.swift
//  Set
//
//  Created by Owen Yang on 6/13/21.
//

import UIKit

class Settings: UIViewController {
    
    static var hint: Bool=false
    static let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    let toggle: UISwitch={
        let tg=UISwitch()
        tg.translatesAutoresizingMaskIntoConstraints=false
        tg.addTarget(self, action: #selector(hit), for: .touchUpInside)
        
        let fileURL = URL(fileURLWithPath: "settings", relativeTo: directoryURL).appendingPathExtension("txt")
        let fm=FileManager()
        
        do {
            // Get the saved data
            let savedData = try Data(contentsOf: fileURL)
            // Convert the data back into a string
            if let sString = String(data: savedData, encoding: .utf8) {
                if sString=="T" {
                    tg.isOn=true
                    hint=true
                }
            }
        } catch {
            print("No file")
            fm.createFile(atPath: fileURL.path, contents: Data ("F".data(using: .utf8)!), attributes: nil)
        }
        
        return tg
    }()
    
    @objc func hit() {
        Settings.hint = !Settings.hint
        var textString: String=""
        if Settings.hint==true {
            textString="T"
        } else {
            textString="F"
        }
        guard let data = textString.data(using: .utf8) else {
            print("Unable to convert string to data")
            return }
        let fileURL = URL(fileURLWithPath: "settings", relativeTo: Settings.directoryURL).appendingPathExtension("txt")
        do {
            try data.write(to: fileURL)
                print("File saved: \(fileURL.absoluteURL)")
        } catch {
            // Catch any errors
            print(error.localizedDescription)
        }
    }
    
    private let text1: UITextView={
        let textView=TextView.init(text2: "Hints").textView
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
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
