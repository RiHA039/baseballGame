//
//  main.swift
//  과제
//
//  Created by 김리하 on 8/26/25.
//

import Foundation



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
                continue
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
