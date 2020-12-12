//
//  main.swift
//  Rubik's Cube
//
//  Created by Lia on 2020/12/09.
//

import Foundation

// STEP 2: 평면 큐브 구현하기

let cube1 = [["R", "R", "W"], ["G", "C", "W"], ["G", "B", "B"]]
let flatCube1 = FlatCube(cube: cube1)

flatCube1.printCube()
var check = true

// 평면큐브 돌리기 구현
repeat {
    print("\nCUBE > ", terminator: "")
    
    let userInput = readLine()!
    let input = multiNotation(userInput)
    
    for index in 0..<input.count {
        if input[index] == "Q" {
            check = false
            break
        }
        print("\n",input[index])
        flatCube1.push(notation: input[index])
        flatCube1.printCube()
    }
} while check
print("Bye~~")
