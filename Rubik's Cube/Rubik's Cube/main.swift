//
//  main.swift
//  Rubik's Cube
//
//  Created by Lia on 2020/12/09.
//

import Foundation

// STEP 1: 단어 밀어내기

//print("enter a word, an integer (-100 <= N < 100), L or R")
//print("ex) apple 3 L \n\ninput: ", terminator:"")
//
//let input1 = readLine()!
//var test1 = step1(input1)
//test1.calString()
//print(test1.pushString())


// ***********************************************************
// STEP 2: 평면 큐브 구현하기

//let cube1 = [["R", "R", "W"], ["G", "C", "W"], ["G", "B", "B"]]
//let flatCube1 = flatCube(cube: cube1)
//
//flatCube1.printCube()
//var check = true
//
//// 평면큐브 돌리기 구현
//repeat {
//    print("\nCUBE > ", terminator: "")
//
//    let userInput = readLine()!
//    let input = multiNotation(userInput)
//
//    for index in 0..<input.count {
//        if input[index] == "Q" {
//            check = false
//            break
//        }
//        print("\n",input[index])
//        flatCube1.push(notation: input[index])
//        flatCube1.printCube()
//    }
//} while check
//print("Bye~~")


// ***********************************************************
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
