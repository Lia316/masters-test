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

struct CubeInfo {
    let position: [[String]]
    let RC: Bool // row: true, column: false
    let num: Int
    let reverse: Bool
}


class Rubiks {
    var cube: RubiksCube
    
    init(cube: RubiksCube) {
        self.cube = cube
    }
    
    func readInfo(_ cubeInfo: CubeInfo) -> [String]{
        var arr: [String]
        if cubeInfo.RC{
            arr = cubeInfo.position[cubeInfo.num]
        } else {
            arr = [cubeInfo.position[0][cubeInfo.num]]
            arr.append(cubeInfo.position[1][cubeInfo.num])
            arr.append(cubeInfo.position[2][cubeInfo.num])
        }
        if cubeInfo.reverse { arr = arr.reversed() }
        return arr
    }
    
    func mergePush(_ cube1: CubeInfo, _ cube2: CubeInfo, _ cube3: CubeInfo, _ cube4: CubeInfo, counterClockwise: Bool) -> [String] {
        var mergeArr = readInfo(cube1) + readInfo(cube2) + readInfo(cube3) + readInfo(cube4)
        
        if counterClockwise { mergeArr = mergeArr.reversed()}
        mergeArr.append(mergeArr[0])
        mergeArr.remove(at: 0)
        if counterClockwise { mergeArr = mergeArr.reversed()}
        
        return mergeArr
    }
    
    func turnCube(notation: String) {
        let temp = CubeInfo.init(position: [[""]], RC: true, num: 0, reverse: true)
        var list = (temp, temp, temp, temp)
        var direction = true
        
        switch notation {
        case "F", "F'":
            let R = CubeInfo.init(position: cube.R, RC: false, num: 0, reverse: false)
            let D = CubeInfo.init(position: cube.D, RC: true, num: 0, reverse: true)
            let L = CubeInfo.init(position: cube.L, RC: false, num: 2, reverse: true)
            let U = CubeInfo.init(position: cube.U, RC: true, num: 2, reverse: false)
            list = (R, D, L, U)
            direction = notation == "F'"
        case "R":
            <#code#>
        case "U":
            <#code#>
        case "B":
            <#code#>
        case "L":
            <#code#>
        case "D":
            <#code#>
        default:
            <#code#>
        }
        let resultArr = mergePush(list.0, list.1, list.2, list.3, counterClockwise: direction)
        // pushCube(R,D,L,U, arrMerge)
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
