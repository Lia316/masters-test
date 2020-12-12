//
//  step-2.swift
//  Rubik's Cube
//
//  Created by Lia on 2020/12/09.
//

import Foundation

// STEP 2: 평면 큐브 구현하기

class FlatCube {
    var cube: [[String]]
    
    init(cube: [[String]]) {
        self.cube = cube
    }
    
    // 1차원 배열과 방향을 입력받아 수평으로 밀어내는 함수
    func horizontal(row: [String], direction: Bool) -> [String] {
        var tempArr = row
        if !direction { tempArr = tempArr.reversed()}
        
        tempArr.append(tempArr[0])
        tempArr.remove(at: 0)
        
        if !direction { tempArr = tempArr.reversed()}
        return tempArr
    }
    
    // 1차원 배열과 방향을 입력받아 수직으로 밀어내는 함수
    func vertical(column: Int, direction: Bool) {
        var tempArr = [cube[0][column], cube[1][column], cube[2][column]]
        tempArr = horizontal(row: tempArr, direction: direction)
        
        cube[0][column] = tempArr[0]
        cube[1][column] = tempArr[1]
        cube[2][column] = tempArr[2]
    }
    
    // 큐브 기호대로 밀어내는 함수
    func push(notation: String) {
        switch notation {
        case "U": // 가장 윗줄을 왼쪽으로 한 칸 밀기
            cube[0] = horizontal(row: cube[0], direction: true)
        case "U'": // 가장 윗줄을 오른쪽으로 한 칸 밀기
            cube[0] = horizontal(row: cube[0], direction: false)
        case "R": //가장 오른쪽 줄을 위로 한 칸 밀기
            vertical(column: 2, direction: true)
        case "R'": // 가장 오른쪽 줄을 아래로 한 칸 밀기
            vertical(column: 2, direction: false)
        case "L": // 가장 왼쪽 줄을 아래로 한 칸 밀기 (L의 경우 R과 방향이 반대임을 주의한다.)
            vertical(column: 0, direction: false)
        case "L'": // 가장 왼쪽 줄을 위로 한 칸 밀기
            vertical(column: 0, direction: true)
        case "D": // 가장 아랫줄을 오른쪽으로 한 칸 밀기 (D의 경우도 U와 방향이 반대임을 주의한다.)
            cube[2] = horizontal(row: cube[2], direction: false)
        case "D'": // 가장 아랫줄을 왼쪽으로 한 칸 밀기
            cube[2] = horizontal(row: cube[2], direction: true)
        default:
            print("error")
            break
        }
    }
    
    func printCube() {
        print(cube[0][0], cube[0][1], cube[0][2])
        print(cube[1][0], cube[1][1], cube[1][2])
        print(cube[2][0], cube[2][1], cube[2][2])
    }
}

// 여러 입력을 처리하는 함수
func multiNotation(_ input: String) -> [String] {
    let arr = Array(input)
    var result = [String]()
    
    if arr.count == 1 {return [input]}
    
    for index in 0..<arr.count {
        if index < arr.count - 1 && arr[index + 1] == "'" {
            result.append("\(arr[index])'")
            continue
        } else if arr[index] != "'" {
            result.append("\(arr[index])")
        }
    }
    return result
}
