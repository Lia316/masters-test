# STEP 3. 루빅스 큐브

## 코드 개요

- main: Rubik's Cube 변수 선언 및 클래스 인스턴스 생성

- 루빅스 큐브 & 회전 행렬 정보 구조체
    - `RubiksCube`
    - `CubeInfo`
- `Rubiks` 크래스
    1. 프로퍼티 및 초기화 함수
    2. 큐브 게임 진행을 위한 메소드들
    3. 큐브 회전 기능을 위한 메소드들

---

## 코드 동작

### 1. 입력 및 게임 진행

- main 에서 생성한 변수로 초기화한 `RubiksCube` 인스턴스를 생성한다
    - `cube` : 변하는 큐브
    - `initialCube` : 처음 받은 큐브 면이 맞춰진 상태의 큐브
    - `CubeInfo` 타입의 F, R, U, B, L, D : 회전 시 변하는 변두리 라인의 정보
    - `count` : 조작 횟수 저장을 위한 프로퍼티

- 초기화
    - `cube` 와  `initialCube` 모두 전달받은 값으로 초기화
    - `initialCube` 는 이 정보를 끝까지 가지고 있음

- 게임 진행을 위한 메소드
    - `playRubiksCube()`
        - 경과 시간 확인: `timeIntervalSince1970` 을 통해 처음 시간과 나중 시간을 뺀 값을 출력한다.
        - 처음 큐브 상태와 임의로 섞은 큐브 상태 출력
        - 반복 :  `Q`  입력이나 모든 면을 맞추면(`didSolve()`) `break`
        - `countCommand()` 메소드를 통해 유효한 조작만 세고, 유효한 조작일 경우, 명령어 출력
        - `turnCube()`  조작에 따라 큐브 회전
        - `printRubiksCube` 회전한 큐브 출력
        - 끝날 경우, 경과시간, 조작 개수, 인사말 출력

    - 보조 메소드
    1. `countCommand(input: String)` : 큐브 조작 명령어 집합에 포함된 입력이면 `true` , count++ 
    else `false`
    2. `timeCheck(startTime: TimeInterval)` : "mm:ss" 형식으로 경과시간 출력
    3. `multiNotation(input: String)` : 여러 입력을 한 조작 명령어 배열로 처리

---

### 2. 큐브 회전 기능

#### `readInfo(cubeInfo: CubeInfo)`

- `mergeAndPush` 에 쓰일 메소드
- `cubeInfo`  즉, 큐브의 위치/행렬/반대방향 여부 정보를 받아 적절한 배열 값 리턴한다
- 열(column) 은 배열 하나하나 읽고, 반대방향은 처음과 끝에 `reversed()` 를 사용하여 돌린다

#### `mergeAndPush(cube1, 2, 3, 4: CubeInfo, clockwise: Bool)` 메소드

- `updateBorderCube()` 의 `pushedArr` 에 쓰일 정보
- 큐브를 돌릴 때, 회전하는 변두리 4 line 을 합쳐 3칸 회전한다
- `readInfo()` 를 사용하여 각 line 의 배열을 읽어 합친다
- 시계 방향/ 반시계 방향으로 `append()`,  `remove`,   `reversed()` 를 사용하여 3칸 회전한다.
- 회전으로 변한 배열 값을 리턴한다

#### `updateBorderCube(cubeList: [CubeInfo], pushedArr: [String])` 메소드

- 기호에 따른 변경 정보를 배열로 받아 큐브 프로퍼티에 업데이트하는 메소드
- 기호에 따른 변경 위치 정보를 `cubeList`로 받고 & 변경 정보(배열) `pushedArr` 도 전달받는다.
- 위치/행렬/반대방향 여부에 따라 `alterCubeLine()` 로 변경된 값 업데이트
- `alterCubeLine()` : 몇번째 행/렬 이냐에 따라 다르게 값을 할당하는 함수

#### `rotateCenter(center: [[String]], clockwise: Bool)` 메소드

- 회전 기호 면을 회전시키는 메소드
- ex) notation: R -> R이 시계방향으로 회전하고 주변 border도 회전
- 회전 기호 & ' 여부 를 입력받아 해당 면을 2칸 회전한다
- 움직이지 않는 가장 가운데 면을 제외한 면을 배열로 병합하고, 시계방향일 경우 `reversed()` 를 사용

#### `turnCube(notation: String)` 메소드

- 메인 회전 기능을 수행하는 메소드 :  기호에 따라 모든 큐브 면을 회전시킴
- 조작 기호를 입력 받아, 기호에 따라 변해야하는 line 리스트를 `switch`문으로 설정
- line 리스트를 `mergeAndPush()`로 넘겨줘, 병합 후 3칸 회전한 배열을 받는다
- 배열을 `updateBorderCube()` 로 넘겨줘, 회전한 정보를 업데이트한다
- `rotateCenter()` 로 중심도 회전한다

#### `mixRandom()` 메소드

- 무작위로 큐브 섞기 기능
- 기호를 숫자로 매칭한 딕셔너리 생성
- `for` 문으로 난수(0<N<13, 정수)를 11번 생성하고, 해당 난수에 해당하는 큐브 기호로 바꿔준다
- 큐브 기호에 맞게 `turnCube()` 를 사용하여 섞어준다
- 섞은 큐브 상태 출력

#### `didSolve()` 메소드

- 큐브 면을 다 맞췄는지 확인
- `Rubiks` 클래스 프로퍼티인 `cube` 와  `initialCube` 사용
- `cube`  ≠   `initialCube`  일 경우, `false`

---

### 3. 출력

- `printLine(_ arr: [String], _ type: Int)` 메소드
    - `printRubiksCube()` 를 위한 메소드
    - 목적: row 한 줄을, 적절한 공백에 맞춰 출력하기 위함
    - `switch`문 을 사용하여, `type` 값이 음수면 앞 공백, 0이면 줄바꿈, 양수면 뒤 공백을 준다

- `printRubiksCube()` 메소드
    - `printLine()` 을 사용하여 한 줄씩 출력
    - 전개도 형식에 맞게 출력
