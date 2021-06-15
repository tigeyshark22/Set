//
//  Card.swift
//  Set
//
//  Created by Owen Yang on 6/14/21.
//

struct Card {
    var number: Int
    var color: Int
    var shape: Int
    var shade: Int
    var selected: Bool
    
    func checkSet(c2: Card, c3: Card)->Bool {
        if ((number+c2.number+c3.number)%3 != 0) {
            return false
        }
        if ((color+c2.color+c3.color)%3 != 0) {
            return false
        }
        if ((shape+c2.shape+c3.shape)%3 != 0) {
            return false
        }
        if ((shade+c2.shade+c3.shade)%3 != 0) {
            return false
        }
        return true
    }
    
    func getPic()->String {
        return "set\(27*color+9*shape+3*shade+number)"
    }
}
