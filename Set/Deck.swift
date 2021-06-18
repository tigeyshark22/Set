//
//  Deck.swift
//  Set
//
//  Created by Owen Yang on 6/14/21.
//

class Deck {
    var queue: [Card]
    var current: [Card]
    var setList: [[Int]]
    var selected: [Int]
    var removeCards: Bool
    
    init() {
        queue=[]
        current=[]
        setList=[]
        selected=[-1,-1,-1]
        removeCards=false
        
        for i in 0..<3 {
            for j in 0..<3 {
                for k in 0..<3 {
                    for l in 0..<3 {
                        let randNum=Int.random(in: 0...queue.count)
                        queue.insert(Card(number: i, color: j, shape: k, shade: l, selected: false), at: randNum)
                    }
                }
            }
        }
        
        while current.count<12 || setList.isEmpty {
            for _ in 0..<3 {
                current.append(queue.remove(at: 0))
            }
            checkCurr()
        }
    }
    
    func updateCurr() {
        if !checkSelected().isEmpty {
            var offset=0
            for i in checkSelected() {
                current.remove(at: i-offset)
                offset+=1
                if !queue.isEmpty && current.count<12 {
                    offset-=1
                    current.insert(queue.remove(at: 0), at: i)
                    removeCards=false
                }
                else {
                    removeCards=true
                }
            }
        }
        checkCurr()
        if !queue.isEmpty {
            while current.count<12 || setList.isEmpty {
                for _ in 0..<3 {
                    current.append(queue.remove(at: 0))
                }
                checkCurr()
            }
        }
    }
    
    func checkCurr() {
        setList=[]
        if current.count>0 {
            for i in 0..<current.count-2 {
                for j in i+1..<current.count-1 {
                    for k in j+1..<current.count {
                        if current[i].checkSet(c2: current[j], c3: current[k]) {
                            setList.append([i,j,k])
                        }
                    }
                }
            }
        }
    }
    
    func endGame()->Bool {
        if queue.isEmpty && setList.isEmpty {
            return true
        }
        return false
    }
    
    func getSelected()->[Int] {
        var count=0
        for i in 0..<current.count {
            if current[i].selected {
                selected[count]=i
                count+=1
                current[i].selected=false
            }
        }
        return selected
    }
    
    func getCardSelected()->[Card] {
        let a=getSelected()
        var b: [Card]=[]
        for i in 0..<3 {
            b[i]=current[a[i]]
        }
        return b
    }
    
    func checkSelected()->[Int] {
        for i in setList {
            if i.elementsEqual(selected) {
                return i
            }
        }
        return []
    }
    
    func changeSelected() {
        getSelected()
        if selected[2] != -1 {
            updateCurr()
            selected[2] = -1
        }
    }
}
