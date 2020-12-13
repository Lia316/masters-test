//
//  step-3.swift
//  Rubik's Cube
//
//  Created by Lia on 2020/12/10.
//

import Foundation

// STEP 3: 루빅스 큐브 구현하기

// MARK:- 루빅스 큐브 & 회전 행렬 정보 구조체
struct RubiksCube {
    var F: [[String]] // Front
    var B: [[String]] // Back
    var L: [[String]] // Left
    var R: [[String]] // Right
    var U: [[String]] // Up
    var D: [[String]] // Down
}

// 변두리 회전을 위한 정보
// ex) Back 회전 시 : 변두리 [U,L,D,R] 회전
//     이 중 U의 정보 [position: cube.U, name: "U", row: true, num: 0, reverse: false]
//     = up의 정보는 cube.U, "U" 이고, 정방향 0행 을 가지고 있어
struct CubeInfo {
    let position: [[String]]
    let name: String
    let row: Bool // row: true, column: false
    let num: Int
    let reverse: Bool
}
let tempInfo = CubeInfo.init(position: [[""]], name: "", row: true, num: 0, reverse: true)

// MARK:- Rubik's Cube class
class Rubiks {
    var cube: RubiksCube
    let initialCube: RubiksCube
    var F: CubeInfo = tempInfo, R = tempInfo, U = tempInfo, B = tempInfo, L = tempInfo, D = tempInfo
    var count = 0
    
    init(cube: RubiksCube) {
        self.cube = cube
        self.initialCube = cube
    }
    
    // MARK:- 큐브 게임 진행을 위한 메소드
    func playRubiksCube() {
        var check = true
        let startTime = Date().timeIntervalSince1970

        print()
        printRubiksCube()
        mixRandom()

        repeat {
            print("\nCUBE > ", terminator: "")
            let input = multiNotation(readLine()!)
            
            for index in 0..<input.count {
                if input[index] == "Q" {
                    check = false
                    break
                }
                countCommand(input: input[index]) ? print("\n",input[index]) : print("\ninvalid!")
                turnCube(notation: input[index])
                printRubiksCube()
                if didSolve() {
                    print("🥳 : 큐브 맞추기 성공!!\n     축하합니다!🎉\n")
                    check = false
                    break
                }
            }
        } while check

        print("경과 시간: \(timeCheck(startTime))")
        print("조작 개수: \(count)")
        print("이용해주셔서 감사합니다. 뚜뚜뚜.\n")
    }
    
    func countCommand(input: String) -> Bool {
        let validNotion = Set(["F", "F'", "B", "B'", "L", "L'", "R", "R'", "U", "U'", "D", "D'"])
        if validNotion.contains(input) { count += 1 }
        
        return validNotion.contains(input)
    }
    
    func timeCheck(_ startTime: TimeInterval) -> String {
        let endTime = Date().timeIntervalSince1970
        let duration = Date(timeIntervalSince1970: endTime - startTime)
        let formateTime = DateFormatter()
        formateTime.dateFormat = "mm:ss"

        return formateTime.string(from: duration)
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
    
    // MARK:- 큐브 기능 구현 시작
    // mergeAndPush 에 쓰일 메소드
    // : 큐브의 위치/행렬/반대방향 여부 정보 -> 적절한 배열 값 리턴
    func readInfo(_ cubeInfo: CubeInfo) -> [String]{
        var arr: [String]
        if cubeInfo.row{
            arr = cubeInfo.position[cubeInfo.num]
        } else {
            arr = [cubeInfo.position[0][cubeInfo.num]]
            arr.append(cubeInfo.position[1][cubeInfo.num])
            arr.append(cubeInfo.position[2][cubeInfo.num])
        }
        if cubeInfo.reverse { arr = arr.reversed() }
        return arr
    }
    
    // updateBorderCube 의 pushedArr 에 쓰일 정보
    // : 큐브 기호에 따라 돌아가는 면의 정보 & 시계 방향 정보 -> 병합 후 3칸 돌린 배열 리턴
    func mergeAndPush(_ cube1: CubeInfo, _ cube2: CubeInfo, _ cube3: CubeInfo, _ cube4: CubeInfo, clockwise: Bool) -> [String] {
        var mergedArr = readInfo(cube1) + readInfo(cube2) + readInfo(cube3) + readInfo(cube4)
        
        if clockwise { mergedArr = mergedArr.reversed()}
        for _ in 1...3{
            mergedArr.append(mergedArr[0])
            mergedArr.remove(at: 0)
        }
        if clockwise { mergedArr = mergedArr.reversed()}
        
        return mergedArr
    }
    
    // 기호에 따른 변경 정보를 배열로 받아 큐브 프로퍼티에 업데이트하는 메소드
    // : 기호에 따른 변경 위치 정보 리스트 & 변경 정보(배열) -> 위치/행렬/반대방향 여부에 따라 변경된 값 업데이트
    func updateBorderCube(cubeList: [CubeInfo], pushedArr: [String]) {
        var arr = pushedArr
        
        for index in 0..<4 {
            var subArr = [arr[0], arr[1], arr[2]]
            arr.remove(at: 0)
            arr.remove(at: 0)
            arr.remove(at: 0)
            if cubeList[index].reverse { subArr = subArr.reversed()}
            
            func alterCubeLine(_ position: [[String]], _ row: Bool, _ num: Int) -> [[String]]{
                var cube = position
                if row {
                    cube[num] = subArr
                } else {
                    cube[0][num] = subArr[0]
                    cube[1][num] = subArr[1]
                    cube[2][num] = subArr[2]
                }
                return cube
            }
            switch cubeList[index].name {
            case "F": cube.F = alterCubeLine(cube.F, cubeList[index].row, cubeList[index].num)
            case "R": cube.R = alterCubeLine(cube.R, cubeList[index].row, cubeList[index].num)
            case "U": cube.U = alterCubeLine(cube.U, cubeList[index].row, cubeList[index].num)
            case "B": cube.B = alterCubeLine(cube.B, cubeList[index].row, cubeList[index].num)
            case "L": cube.L = alterCubeLine(cube.L, cubeList[index].row, cubeList[index].num)
            case "D": cube.D = alterCubeLine(cube.D, cubeList[index].row, cubeList[index].num)
            default : break
            }
        }
    }
    
    // 회전 기호 면을 회전시키는 메소드 ex) notation: R -> R이 시계방향으로 회전하고 주변 border도 회전
    // : 회전 기호 & ' 여부 -> 움직이지 않는 가장 가운데 면을 제외한 면 배열로 병합 -> 2칸 회전 값 리턴
    func rotateCenter(center: [[String]], clockwise: Bool) -> [[String]] {
        var mergedArr = center[0] + [center[1][2], center[2][2], center[2][1], center[2][0], center[1][0]]
        
        if clockwise {mergedArr = mergedArr.reversed()}
        mergedArr.append(mergedArr[0])
        mergedArr.append(mergedArr[1])
        mergedArr.remove(at: 0)
        mergedArr.remove(at: 0)
        if clockwise {mergedArr = mergedArr.reversed()}
        
        var rotatedCenter = [[mergedArr[0], mergedArr[1], mergedArr[2]]]
        rotatedCenter.append([mergedArr[7], center[1][1], mergedArr[3]])
        rotatedCenter.append([mergedArr[6], mergedArr[5], mergedArr[4]])
        
        return rotatedCenter
    }
    
    // 기호에 따라 모든 큐브 면을 회전하는 메소드
    // : 기호에 따라 변해야하는 line 리스트 설정 -> mergeAndPush로 병합 후 3칸 회전 -> updateBorderCube로 정보 업데이트 -> rotateCenter로 중심도 회전
    func turnCube(notation: String) {
        switch notation {
        case "F", "F'":
            R = CubeInfo.init(position: cube.R, name: "R", row: false, num: 0, reverse: false)
            D = CubeInfo.init(position: cube.D, name: "D",row: true, num: 0, reverse: true)
            L = CubeInfo.init(position: cube.L, name: "L",row: false, num: 2, reverse: true)
            U = CubeInfo.init(position: cube.U, name: "U",row: true, num: 2, reverse: false)
            let resultArr = mergeAndPush(R, D, L, U, clockwise: notation == "F")
            updateBorderCube(cubeList: [R, D, L, U], pushedArr: resultArr)
            cube.F = rotateCenter(center: cube.F, clockwise: notation == "F")
        case "R", "R'":
            D = CubeInfo.init(position: cube.D, name: "D", row: false, num: 2, reverse: true)
            F = CubeInfo.init(position: cube.F, name: "F",row: false, num: 2, reverse: true)
            U = CubeInfo.init(position: cube.U, name: "U",row: false, num: 2, reverse: true)
            B = CubeInfo.init(position: cube.B, name: "B",row: false, num: 0, reverse: false)
            let resultArr = mergeAndPush(D, F, U, B, clockwise: notation == "R")
            updateBorderCube(cubeList: [D, F, U, B], pushedArr: resultArr)
            cube.R = rotateCenter(center: cube.R, clockwise: notation == "R")
        case "U", "U'":
            B = CubeInfo.init(position: cube.B, name: "B", row: true, num: 0, reverse: true)
            R = CubeInfo.init(position: cube.R, name: "R",row: true, num: 0, reverse: true)
            F = CubeInfo.init(position: cube.F, name: "F",row: true, num: 0, reverse: true)
            L = CubeInfo.init(position: cube.L, name: "L",row: true, num: 0, reverse: true)
            let resultArr = mergeAndPush(B, R, F, L, clockwise: notation == "U")
            updateBorderCube(cubeList: [B, R, F, L], pushedArr: resultArr)
            cube.U = rotateCenter(center: cube.U, clockwise: notation == "U")
        case "B", "B'":
            U = CubeInfo.init(position: cube.U, name: "U", row: true, num: 0, reverse: true)
            L = CubeInfo.init(position: cube.L, name: "L",row: false, num: 0, reverse: false)
            D = CubeInfo.init(position: cube.D, name: "D",row: true, num: 2, reverse: false)
            R = CubeInfo.init(position: cube.R, name: "R",row: false, num: 2, reverse: true)
            let resultArr = mergeAndPush(U, L, D, R, clockwise: notation == "B")
            updateBorderCube(cubeList: [U, L, D, R], pushedArr: resultArr)
            cube.B = rotateCenter(center: cube.B, clockwise: notation == "B")
        case "L", "L'":
            U = CubeInfo.init(position: cube.U, name: "U", row: false, num: 0, reverse: false)
            F = CubeInfo.init(position: cube.F, name: "F",row: false, num: 0, reverse: false)
            D = CubeInfo.init(position: cube.D, name: "D",row: false, num: 0, reverse: false)
            B = CubeInfo.init(position: cube.B, name: "B",row: false, num: 2, reverse: true)
            let resultArr = mergeAndPush(U, F, D, B, clockwise: notation == "L")
            updateBorderCube(cubeList: [U, F, D, B], pushedArr: resultArr)
            cube.L = rotateCenter(center: cube.L, clockwise: notation == "L")
        case "D", "D'":
            L = CubeInfo.init(position: cube.L, name: "L", row: true, num: 2, reverse: false)
            F = CubeInfo.init(position: cube.F, name: "F",row: true, num: 2, reverse: false)
            R = CubeInfo.init(position: cube.R, name: "R",row: true, num: 2, reverse: false)
            B = CubeInfo.init(position: cube.B, name: "B",row: true, num: 2, reverse: false)
            let resultArr = mergeAndPush(L, F, R, B, clockwise: notation == "D")
            updateBorderCube(cubeList: [L, F, R, B], pushedArr: resultArr)
            cube.D = rotateCenter(center: cube.D, clockwise: notation == "D")
        default:
            break
        }
    }
    
    // 무작위 섞는 메소드
    func mixRandom(){
        let notation = [1: "F", 2: "F'", 3: "B", 4: "B'", 5: "L", 6: "L'", 7: "R", 8: "R'", 9: "U", 10: "U'", 11: "D", 12: "D'"]
        var mixList = [String]()
        
        for index in 0...10 {
            mixList.append(notation[Int.random(in: 1...12)]!)
            turnCube(notation: mixList[index])
        }
        print("[mixed] ", mixList, "\n")
        printRubiksCube()
    }
    
    // 큐브 면을 다 맞췄는지 확인하는 함수
    func didSolve() -> Bool {
        if cube.F != initialCube.F { return false }
        if cube.R != initialCube.R { return false }
        if cube.U != initialCube.U { return false }
        if cube.B != initialCube.B { return false }
        if cube.L != initialCube.L { return false }
        if cube.D != initialCube.D { return false }
        return true
    }
    
    // printRubiksCube 를 위한 메소드 : row 와 앞뒤 공백 간격 -> 출력
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
    
    // 루빅스 큐브를 전개도 형식에 맞게 출력하는 메소드
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



