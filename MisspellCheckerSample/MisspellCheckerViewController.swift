//
//  MisspellCheckerViewController.swift
//  MisspellCheckerSample
//
//  Created by 小川卓馬 on 2021/04/29.
//


/*
 --- 実装内容 ---
 
 TextViewに入力された文字列をスペース（または改行）で分割し、配列に格納する。
 文字の配列の中身の一つ一つを誤字チェックする。
 誤字を抽出して、誤字配列（misspellWords）に格納する。
 誤字配列を一文字ずつ改行で区切って、下のTextViewに表示する。
 
 --- 改善点 ---
 日本語など他言語が入力された際の制御。
 現時点では日本語を入力してもスペルミスとは判定されない状況。
 使用できるキーボードで制御するか、英語以外が入力されていた場合の対処をするか。
 
 */

import UIKit

final class MisspellCheckerViewController: UIViewController {

    @IBOutlet weak private var inputTextView: UITextView!
    @IBOutlet weak private var outputTextView: UITextView!
    
    @IBAction private func checkButtonTapped(_ sender: UIButton) {
        if inputTextView.text! == "" {
            outputTextView.text! = "英単語を入力してください。"
            return
        }
        outputTextView.text! = misspellingExtraction(words: inputTextView.text!)
        
    }
    
}

extension MisspellCheckerViewController {
    
    private func misspellingExtraction(words: String) -> String {
        var misspellWords: [String] = []
        let wordsArray = words.components(separatedBy: CharacterSet(charactersIn: " \n"))
        
        for word in wordsArray {
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: word.count)
            let wordRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            if wordRange.location != NSNotFound {
                misspellWords.append(word)
            }
        }

        var displayMisspellWords = misspellWords.reduce("") { (str1, str2) -> String in
            if str1 != "" {
                return "\(str1)\n\(str2)"
            } else {
                return str2
            }
        }
        
        if displayMisspellWords == "" {
            displayMisspellWords = "スペルミスはありません。"
        }
        
        return displayMisspellWords
        
    }
}

