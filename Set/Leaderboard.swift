//
//  Leaderboard.swift
//  Set2
//
//  Created by Owen Yang on 6/13/21.
//

import UIKit

struct Leaderboard {
    let names: [String]
    let times: [Int]
    let font: UIFont = UIFont(name: "GillSans", size: 16.0)!
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    init() {
        names=[]
        times=[]
        let fileURL = URL(fileURLWithPath: "testing123", relativeTo: directoryURL).appendingPathExtension("txt")
        
        do {
            // Get the saved data
            let savedData = try Data(contentsOf: fileURL)
            // Convert the data back into a string
            if let savedString = String(data: savedData, encoding: .utf8) {
                print(savedString)
            }
        } catch {
         // Catch any errors
            print("Unable to read the file")
        }
        
       // let myString = "Saving data with FileManager is easy!"
        //guard let data = myString.data(using: .utf8) else {
         //   print("Unable to convert string to data")
          //  return
        //}
        
        //do {
          //  try data.write(to: fileURL)
            //    print("File saved: \(fileURL.absoluteURL)")
        //} catch {
            // Catch any errors
          //  print(error.localizedDescription)
        //}
    }
}
