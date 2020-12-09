//
//  step-1.swift
//  Rubik's Cube
//
//  Created by Lia on 2020/12/09.
//

import Foundation

// STEP 1: 단어 밀어내기

struct step1{
    let word: String
    var integer: Int
    var LR: String
    
    init(_ input: String) {
        let tempArr = input.components(separatedBy: " ")
        word = tempArr[0]
        integer = Int(tempArr[1])!
        LR = tempArr[2]
    }
    
    // 소문자, 음수를 대문자, 양수로 깔끔하게 처리하는 함수
    mutating func calString() {
        if LR == "r" {LR = "R"}
        if LR == "l" {LR = "L"}
        
        if integer < 0 {
            integer *= -1
            LR = LR == "L" ? "R" : "L"
        }
        integer %= word.count
    }
    
    // 양수 입력 받아서 R or L 방향으로 count 보다 작은 n 만큼 미는 함수
    func pushString() -> String {
        if integer == 0 { return word }
        
        var wordArr = word.map{ String($0) }
        if LR == "R" { wordArr = wordArr.reversed()}
        
        for _ in 1...integer {
            wordArr.append(wordArr[0])
            wordArr.remove(at: 0)
        }
        if LR == "R" { wordArr = wordArr.reversed()}
        return wordArr.joined()
    }
}
