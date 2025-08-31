## swift로 야구게임 만들기 ⚾️

> Lv1.
- 1에서 9까지의 서로 다른 임의의 수 3개를 정하고 맞추는 게임입니다
- 정답은 랜덤으로 만듭니다 (1에서 9까지의 서로 다른 임의의 수 3자리)

- 코드 뼈대 보기
```
// main.swift 파일
// 프로젝트 생성시 자동 생성됨

let game = BaseballGame()
game.start() // BaseballGame 인스턴스를 만들고 start 함수를 구현하기


// BaseballGame.swift 파일 생성
class 혹은 struct {
	func start() {
		let answer = makeAnswer() // 정답을 만드는 함수
	}
	
	func makeAnswer() -> Int {
		// 함수 내부를 구현하기
	}
}
```


> Lv2.
 - 정답을 맞추기 위해 3자리 수를 입력하고 힌트를 받습니다
   ⚾️ 힌트는 야구용어인 볼과 스트라이크 입니다
   ⚾️ 같은 자리에 같은 숫자가 있는 경우 스트라이크, 다른 자리에 숫자가 있는 경우 볼입니다
   (정답이 456일 경우: 435는 1스트라이크 1볼, 357은 1스트라이크, 678은 1볼, 123을 입력한 경우 Nothing 입니다)
- 만약 올바르지 않은 입력값에 대해서는 오류 문구를 보여주세요
- 3자리 숫자가 정답과 같은 경우 게임이 종료됩니다

- 실행 예시(정답: 456)13123213

```
< 게임을 시작합니다 >
숫자를 입력하세요
435
1스트라이크 1볼

숫자를 입력하세요
357
1스트라이크

숫자를 입력하세요
123
Nothing

숫자를 입력하세요
dfg // 세 자리 숫자가 아니어서 올바르지 않은 입력값
올바르지 않은 입력값입니다

숫자를 입력하세요
199 // 9가 두번 사용되어 올바르지 않은 입력값
올바르지 않은 입력값입니다

숫자를 입력하세요
103 // 0이 사용되어 올바르지 않은 입력값
올바르지 않은 입력값입니다

숫자를 입력하세요
456
정답입니다!
```

 - 코드 뼈대 보기
 
 ```
class Example {
	func start() {
		let answer = makeAnswer() // 정답을 만드는 함수
		
		while true {
			// 1. 유저에게 입력값을 받음
			
			// 2. 정수로 변환되지 않는 경우 반복문 처음으로 돌아가기
			
			// 3. 세자리가 아니거나, 0을 가지거나 특정 숫자가 두번 사용된 경우 반복문 처음으로 돌아가기
			
			// 4. 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기
			// 만약 정답이라면 break 호출하여 반복문 탈출
		}
	}
}

 ```
<img width="642" height="478" alt="스크린샷 2025-08-31 오후 2 52 34" src="https://github.com/user-attachments/assets/a826e251-2389-4c3d-bf1d-323590fdc8a0" />





정답을 만드는 함수 부분이에요 
- `while`반복문으로 정답을 맞출 때까지 게임이 계속 돌아갈 수 있도록 무한 반복을 해줍니다.
- `guard let`은 단순히 값이 존재하는지만 확인해주기에 `isValidInput(input)`함수를 추가해서 추가 조건들을 검사하게 만들어주었습니다.(규칙들)
- `readLine()` 은 입력을 모두 optional String형으로 처리하기 때문에 또 다른 처리가 필요합니다. 
( 즉, 입력한 값만 읽어들이고 `Optional String`으로 반환해버린다는 것...)
- 그래서 `Optional`을 벗기기 위해 안전하게 벗기는 방법으로 `guard let input = readLine()`을 사용해주었고 `readLine()`이 nil이면 `else`구문이 실행되고 `continue`로 반복문 처음으로 돌아가게 만들어주었습니다. (프로그램이 값이 없어서 튕기는 것을 방지하고 다시 입력 받을 수 있게 만든 것!)
- `let guess = input.map { Int(String($0))! }` 으로는 문자열 입력을 숫자 배열로 바꿔주었습니다.
⚾️ `.map`: "435"라는 문자열을 [ 4, 3, 5]로 배열을 만들어줌
⚾️ `$0`: `.map`에서 꺼낸 글자
⚾️ `string($0)`: 꺼내온 글자가 `character`(글자) 타입이기에 `String`(문자열)로 바꿔줌
⚾️ `Int(String($0))!`: `String`을 `Int`로 바꾸고 강제 언래핑함(`Int()`는 `옵셔널 Int`(Int?) 를 반환하기 때문에 문자열이 숫자로 변환되지 않거나 에러가 날 수 있기 때문에 강제 언래핑함!)


- 스트라이크가 나오면 `break`를 사용해 게임을 멈춰주고 스트라이크와 볼이 둘 다 없으면 "Nothing"을 출력해줍니다. 나머지 경우에는 "n스트라이크, n볼"로 사용자에게 힌트를 줍니다.

<img width="526" height="181" alt="스크린샷 2025-08-31 오후 4 24 21" src="https://github.com/user-attachments/assets/06768a6b-e53c-40c5-8f95-90d156059122" />

 - 정답을 만드는 함수는 `[Int]` 로 반환해줍니다.
  ⚾️ `while result.count < 3`를 사용해 배열에 3자리 숫자가 채워질 때까지 반복해줌
  ⚾️ `let randonNumber = Int.random(in: 1...9)`: 1부터 9까지 랜덤으로 숫자를 뽑아줌(0은 뺌!)
  ⚾️ `if !result.contains(randomNumber)`: 중복된 숫자가 없을 때만 다음 코드를 실행
  ⚾️ `result.append(randomNumber)`: 중복이 아니면 배열에 추가하고 3자리 숫자가 서로 다른 숫자로 만들어짐

<img width="545" height="231" alt="스크린샷 2025-08-31 오후 4 50 56" src="https://github.com/user-attachments/assets/525ead37-f09a-43b8-8a10-795d65572765" />

- `!= 3`:입력된 문자열 길이가 3이 아니면 함수를 종료하고 "올바르지 않음"으로 반환함
- `isNumber`: 입력한 글자가 숫자인지 검사함
- `!`: 부정 연산자로 숫자가 아닌 글자가 하나라도 들어있으면 바로 false로 반환
- 배열에 0이 들어가지 않도록 설정했기 때문에 들어가면 false로 반환
- Set(digits)`: 배열에서 중복을 제거함
중복이 없으면 길이가 3이어야 하고 3이 아니면 중복된 숫자가 있을 때 false로 반환함

-------------------------------------

```
class BaseballGame {
    func start() {
        
        print("숫자 야구 게임을 시작합니다!")
        print("3자리 숫자를 맞춰보세요!")
        
        let answer = makeAnswer()
        // print(answer)
        
        while true {
            print("숫자를 입력하세요")
            
            guard let input = readLine() else {
                print("입력을 읽을 수 없습니다.")
                continue
            }
            
            if !isValidInput(input) {
                print("올바르지 않은 입력값입니다.")
            }
            
            let guess = input.map { Int(String($0))! }
            
            let (strike, ball) = cheakGuess(answer: answer, guess: guess)
            
            if strike == 3 {
                print("정답입니다!")
                break
            } else if strike == 0 && ball == 0 {
                print("맞는 것 없음")
            } else {
                print("\(strike)스트라이크 \(ball) 볼")
            }
        }
    }
    
    func makeAnswer() -> [Int] {
        var result: [Int] = []
        while result.count < 3 {
            let randomNumber = Int.random(in: 1...9)
            if !result.contains(randomNumber) {
                result.append(randomNumber)
            }
        }
        return result
    }
    
    func isValidInput(_ input: String) -> Bool {
        
        if input.count != 3 { return false }
        
        if !input.allSatisfy( { $0.isNumber }) { return false }
        
        let digits = input.map { Int(String($0))! }
        
        if digits.contains(0) { return false }
        
        if Set(digits).count != 3 { return false }
        
        return true
    }
    
    func cheakGuess(answer: [Int], guess: [Int]) -> (Int, Int) {
        var strike = 0
        var ball = 0
        
        for i in 0..<3 {
            if guess[i] == answer[i] {
                strike += 1
            } else if answer.contains(guess[i]) {
                ball += 1
            }
        }
        
        return (strike, ball)
    }
}


let game = BaseballGame()
game.start()

```






