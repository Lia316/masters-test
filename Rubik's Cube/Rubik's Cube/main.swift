//
//  main.swift
//  Rubik's Cube
//
//  Created by Lia on 2020/12/09.
//

import Foundation

// STEP 1: 단어 밀어내기
print("enter a word, an integer (-100 <= N < 100), L or R")
print("ex) apple 3 L \n\ninput: ", terminator:"")

let input1 = readLine()!
var test1 = step1(input1)
test1.calString()
print(test1.pushString())


