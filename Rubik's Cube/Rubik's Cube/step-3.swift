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
    let name: String
    let RC: Bool // row: true, column: false
    let num: Int
    let reverse: Bool
}
let temp = CubeInfo.init(position: [[""]], name: "", RC: true, num: 0, reverse: true)

class Rubiks {
    var cube: RubiksCube
    var F: CubeInfo = temp, R: CubeInfo = temp, U: CubeInfo = temp, B: CubeInfo = temp, L: CubeInfo = temp, D: CubeInfo = temp
    
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
    
    func mergePush(_ cube1: CubeInfo, _ cube2: CubeInfo, _ cube3: CubeInfo, _ cube4: CubeInfo, clockwise: Bool) -> [String] {
        var mergeArr = readInfo(cube1) + readInfo(cube2) + readInfo(cube3) + readInfo(cube4)
        
        if clockwise { mergeArr = mergeArr.reversed()}
        mergeArr.append(mergeArr[0])
        mergeArr.append(mergeArr[1])
        mergeArr.append(mergeArr[2])
        mergeArr.remove(at: 0)
        mergeArr.remove(at: 0)
        mergeArr.remove(at: 0)
        if clockwise { mergeArr = mergeArr.reversed()}
        
        return mergeArr
    }
    
    func updateBorderCube(_ cubeList: [CubeInfo], pushedArr: [String]) {
        var arr = pushedArr
        
        for index in 0..<4 {
            var subArr = Array(arr[0...2])
            arr.remove(at: 0)
            arr.remove(at: 0)
            arr.remove(at: 0)
            if cubeList[index].reverse { subArr = subArr.reversed()}
            
            func alterCubePlane(_ position: [[String]], _ RC: Bool, _ num: Int) -> [[String]]{
                var cube = position
                if RC {
                    cube[num] = subArr
                } else {
                    cube[0][num] = subArr[0]
                    cube[1][num] = subArr[1]
                    cube[2][num] = subArr[2]
                }
                return cube
            }
            switch cubeList[index].name {
            case "F": cube.F = alterCubePlane(cube.F, cubeList[index].RC, cubeList[index].num)
            case "R": cube.R = alterCubePlane(cube.R, cubeList[index].RC, cubeList[index].num)
            case "U": cube.U = alterCubePlane(cube.U, cubeList[index].RC, cubeList[index].num)
            case "B": cube.B = alterCubePlane(cube.B, cubeList[index].RC, cubeList[index].num)
            case "L": cube.L = alterCubePlane(cube.L, cubeList[index].RC, cubeList[index].num)
            case "D": cube.D = alterCubePlane(cube.D, cubeList[index].RC, cubeList[index].num)
            default : break
            }
        }
    }
    
    func turnCube(notation: String) {
        var list: [CubeInfo]
        var direction: Bool
        
        switch notation {
        case "F", "F'":
            R = CubeInfo.init(position: cube.R, name: "R", RC: false, num: 0, reverse: false)
            D = CubeInfo.init(position: cube.D, name: "D",RC: true, num: 0, reverse: true)
            L = CubeInfo.init(position: cube.L, name: "L",RC: false, num: 2, reverse: true)
            U = CubeInfo.init(position: cube.U, name: "U",RC: true, num: 2, reverse: false)
            list = [R, D, L, U]
            direction = notation == "F"
        case "R", "R'":
            D = CubeInfo.init(position: cube.D, name: "D", RC: false, num: 2, reverse: true)
            F = CubeInfo.init(position: cube.F, name: "F",RC: false, num: 2, reverse: true)
            U = CubeInfo.init(position: cube.U, name: "U",RC: false, num: 2, reverse: true)
            B = CubeInfo.init(position: cube.B, name: "B",RC: false, num: 0, reverse: false)
            list = [D, F, U, B]
            direction = notation == "R"
        case "U", "U'":
            B = CubeInfo.init(position: cube.B, name: "B", RC: true, num: 0, reverse: true)
            R = CubeInfo.init(position: cube.R, name: "R",RC: true, num: 0, reverse: true)
            F = CubeInfo.init(position: cube.F, name: "F",RC: true, num: 0, reverse: true)
            L = CubeInfo.init(position: cube.L, name: "L",RC: true, num: 0, reverse: true)
            list = [B, R, F, L]
            direction = notation == "U"
        case "B", "B'":
            U = CubeInfo.init(position: cube.U, name: "U", RC: true, num: 0, reverse: true)
            L = CubeInfo.init(position: cube.L, name: "L",RC: false, num: 0, reverse: false)
            D = CubeInfo.init(position: cube.D, name: "D",RC: true, num: 2, reverse: false)
            R = CubeInfo.init(position: cube.R, name: "R",RC: false, num: 2, reverse: true)
            list = [U, L, D, R]
            direction = notation == "B"
        case "L", "L'":
            U = CubeInfo.init(position: cube.U, name: "U", RC: false, num: 0, reverse: false)
            F = CubeInfo.init(position: cube.F, name: "F",RC: false, num: 0, reverse: false)
            D = CubeInfo.init(position: cube.D, name: "D",RC: false, num: 0, reverse: false)
            B = CubeInfo.init(position: cube.B, name: "B",RC: false, num: 2, reverse: true)
            list = [U, F, D, B]
            direction = notation == "L"
        case "D", "D'":
            L = CubeInfo.init(position: cube.L, name: "L", RC: true, num: 2, reverse: false)
            F = CubeInfo.init(position: cube.F, name: "F",RC: true, num: 2, reverse: false)
            R = CubeInfo.init(position: cube.R, name: "R",RC: true, num: 2, reverse: false)
            B = CubeInfo.init(position: cube.B, name: "B",RC: true, num: 2, reverse: false)
            list = [L, F, R, B]
            direction = notation == "D"
        default:
            list = []
            direction = false
        }
        let resultArr = mergePush(list[0], list[1], list[2], list[3], clockwise: direction)
        updateBorderCube(list, pushedArr: resultArr)
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
        printLine(cube.U[0], -11)
        printLine(cube.U[1], -11)
        printLine(cube.U[2], -11)
        print()
        printLine(cube.L[0], 3); printLine(cube.F[0], 3); printLine(cube.R[0], 3); printLine(cube.B[0], 0);
        printLine(cube.L[1], 3); printLine(cube.F[1], 3); printLine(cube.R[1], 3); printLine(cube.B[1], 0);
        printLine(cube.L[2], 3); printLine(cube.F[2], 3); printLine(cube.R[2], 3); printLine(cube.B[2], 0);
        print()
        printLine(cube.D[0], -11)
        printLine(cube.D[1], -11)
        printLine(cube.D[2], -11)
        print()
    }
}
