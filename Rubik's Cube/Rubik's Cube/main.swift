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
testRubiks.playRubiksCube()
