//
//  ImageView.swift
//  Set
//
//  Created by Owen Yang on 6/13/21.
//

import UIKit

struct ImageView {
    var imageView: UIImageView
    
    init(picName: String) {
        let imageView=UIImageView(image: UIImage(named: picName))
        imageView.translatesAutoresizingMaskIntoConstraints=false
        imageView.contentMode = .scaleAspectFit
        self.imageView=imageView
    }
}
