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

let front = [["O", "O", "O"], ["O", "O", "O"], ["O", "O", "O"]]
let back = [["Y", "Y", "Y"], ["Y", "Y", "Y"], ["Y", "Y", "Y"]]
let left = [["W", "W", "W"], ["W", "W", "W"], ["W", "W", "W"]]
let right = [["G", "G", "G"], ["G", "G", "G"], ["G", "G", "G"]]
let up = [["B", "B", "B"], ["B", "B", "B"], ["B", "B", "B"]]
let down = [["R", "R", "R"], ["R", "R", "R"], ["R", "R", "R"]]

let cubeForRubiks = RubiksCube.init(F: front, B: back, L: left, R: right, U: up, D: down)
var testRubiks = Rubiks(cube: cubeForRubiks)
testRubiks.printRubiksCube()
