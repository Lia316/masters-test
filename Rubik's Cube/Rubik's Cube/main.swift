//
//  main.swift
//  Rubik's Cube
//
//  Created by Lia on 2020/12/09.
//

import Foundation

// STEP 3: 루빅스 큐브 구현하기

let orange = [["O", "O", "O"], ["O", "O", "O"], ["O", "O", "O"]]
let yellow = [["Y", "Y", "Y"], ["Y", "Y", "Y"], ["Y", "Y", "Y"]]
let white = [["W", "W", "W"], ["W", "W", "W"], ["W", "W", "W"]]
let green = [["G", "G", "G"], ["G", "G", "G"], ["G", "G", "G"]]
let blue = [["B", "B", "B"], ["B", "B", "B"], ["B", "B", "B"]]
let red = [["R", "R", "R"], ["R", "R", "R"], ["R", "R", "R"]]

let cubeForRubiks = RubiksCube.init(F: orange, B: yellow, L: white, R: green, U: blue, D: red)
var testRubiks = Rubiks(cube: cubeForRubiks)
let validNotion = Set(["F", "F'", "B", "B'", "L", "L'", "R", "R'", "U", "U'", "D", "D'"])
var check = true
var count = 0

print()
testRubiks.printRubiksCube()
repeat {
    print("\nCUBE > ", terminator: "")

    let userInput = readLine()!
    let input = multiNotation(userInput)

    for index in 0..<input.count {
        if input[index] == "Q" {
            check = false
            break
        }
        if validNotion.contains(input[index]) {
            count += 1
            print("\n",input[index])
        } else {
            print("\ninvalid!")
        }
        testRubiks.turnCube(notation: input[index])
        testRubiks.printRubiksCube()
        
    }
} while check

print("경과 시간: ")
print("조작 개수: \(count)")
print("이용해주셔서 감사합니다. 뚜뚜뚜.\n")
