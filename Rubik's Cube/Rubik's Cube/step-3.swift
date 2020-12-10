//
//  step-3.swift
//  Rubik's Cube
//
//  Created by Lia on 2020/12/10.
//

import Foundation

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
