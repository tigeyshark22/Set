//
//  LeaderboardView.swift
//  Set
//
//  Created by Owen Yang on 6/13/21.
//

import UIKit

class LeaderboardView: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func getTime(time: Int) -> String {
        return "\(time/60):\(time%60)"
    }
}
