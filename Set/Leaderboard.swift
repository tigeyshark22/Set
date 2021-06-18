//
//  Leaderboard.swift
//  Set2
//
//  Created by Owen Yang on 6/13/21.
//

import UIKit

class Leaderboard {
    var names: [String]
    var times: [Int]
    private var savedString: String
    private var textString: String
    private let font: UIFont = UIFont(name: "GillSans", size: 16.0)!
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let fm=FileManager()
    private var fileName: String
    
    init(fileName: String) {
        self.fileName=fileName
        let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL).appendingPathExtension("txt")
        
        /* //testing purposes
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("not found")
        }
        */
        
        savedString=""
        textString=""
        
        do {
            // Get the saved data
            let savedData = try Data(contentsOf: fileURL)
            // Convert the data back into a string
            if let sString = String(data: savedData, encoding: .utf8) {
                savedString=sString
                textString=sString
            }
        } catch {
            print("No file")
            fm.createFile(atPath: fileURL.path, contents: Data (savedString.data(using: .utf8)!), attributes: nil)

        }
        
        names=[]
        times=[]
        
        while let ind=savedString.firstIndex(of: "\n") {
            let lbRow=savedString[..<ind]
            guard let rowInd=lbRow.firstIndex(of: "*") else { return }
            let rowNextInd=savedString.index(rowInd, offsetBy: 1)
            let name=lbRow[..<rowInd]
            let time=lbRow[rowNextInd...]
            let timeNum=(time as NSString).integerValue
            insertInList(timeNum: timeNum, name: String(name))
            
            let nextInd=savedString.index(ind, offsetBy: 1)
            savedString=String(savedString[nextInd...])
        }
        print(names, times)
    }
    
    func writeTime(name: String, time: Int) {
        insertInList(timeNum: time, name: name)
        let wString="\(name)*\(time)\n"
        textString.append(wString)
        guard let data = textString.data(using: .utf8) else {
            print("Unable to convert string to data")
            return }
        let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL).appendingPathExtension("txt")
        do {
            try data.write(to: fileURL)
                print("File saved: \(fileURL.absoluteURL)")
        } catch {
            // Catch any errors
            print(error.localizedDescription)
        }
    }
    
    private func insertInList(timeNum: Int, name: String) {
        var addInd: Int=0
        while addInd<times.count && times[addInd]<timeNum {
            addInd+=1
        }
        names.insert(name, at: addInd)
        times.insert(timeNum, at: addInd)
    }
}
