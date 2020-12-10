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

struct RubiksCube {
    var F: [[String]] // Front
    var B: [[String]] // Back
    var L: [[String]] // Left
    var R: [[String]] // Right
    var U: [[String]] // Up
    var D: [[String]] // Down
}

class Rubiks {
    var cube: RubiksCube
    
    init(cube: RubiksCube) {
        self.cube = cube
    }
    
    func printLine(_ arr: [String], _ type: Int) {
        var blank: String
        
        switch type {
        case ..<0 : print(String(repeating: " ", count: -type), terminator: ""); blank = "\n"
        case 0    : blank = "\n"
        case 0... : print(" ", terminator: ""); blank = String(repeating: " ", count: type)
        default: blank = "error"
        }
        print(arr[0], arr[1], arr[2], blank, terminator: "")
    }

    func printRubiksCube() {
        printLine(cube.U[0], -16)
        printLine(cube.U[1], -16)
        printLine(cube.U[2], -16)
        print()
        printLine(cube.L[0], 3); printLine(cube.F[0], 3); printLine(cube.R[0], 3); printLine(cube.B[0], 0);
        printLine(cube.L[1], 3); printLine(cube.F[1], 3); printLine(cube.R[1], 3); printLine(cube.B[1], 0);
        printLine(cube.L[2], 3); printLine(cube.F[2], 3); printLine(cube.R[2], 3); printLine(cube.B[2], 0);
        print()
        printLine(cube.D[0], -16)
        printLine(cube.D[1], -16)
        printLine(cube.D[2], -16)
        print()
    }
    
}

let front = [["O", "O", "O"], ["O", "O", "O"], ["O", "O", "O"]]
let back = [["Y", "Y", "Y"], ["Y", "Y", "Y"], ["Y", "Y", "Y"]]
let left = [["W", "W", "W"], ["W", "W", "W"], ["W", "W", "W"]]
let right = [["G", "G", "G"], ["G", "G", "G"], ["G", "G", "G"]]
let up = [["B", "B", "B"], ["B", "B", "B"], ["B", "B", "B"]]
let down = [["R", "R", "R"], ["R", "R", "R"], ["R", "R", "R"]]

let cubeForRubiks = RubiksCube.init(F: front, B: back, L: left, R: right, U: up, D: down)
var testRubiks = Rubiks(cube: cubeForRubiks)
testRubiks.printRubiksCube()
