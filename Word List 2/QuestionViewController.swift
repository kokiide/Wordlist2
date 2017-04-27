//
//  QuestionViewController.swift
//  Word List 2
//
//  Created by Koki Ide on 2017/04/26.
//  Copyright © 2017 kokiide. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    var isAnswered: Bool = false  //回答したか次の問題に行くのかの判断
    var wordArray: [Dictionary<String, String>] = []  //UserDeafultから取る配列
    var shuffledWordArray : [Dictionary<String, String>] = []
    var nowNumber: Int = 0 //現在の回答数
    
    let saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = ""

        // Do any additional setup after loading the view.
    }
    
        //Viewが現れた時に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wordArray = saveData.array (forKey: "WORD") as! [Dictionary<String, String>]
        
        //　問題をシャッフルする
        shuffle()
        questionLabel.text = shuffledWordArray[nowNumber]["english"]
        
    }
    
    func shuffle(){
        while wordArray.count > 0 {
            let index = Int (arc4random()) % wordArray.count
            shuffledWordArray.append(wordArray[index])
            wordArray.remove(at: index)
        }
    }
    
    @IBAction func nextButtonTapped() {
        //回答したか
        if isAnswered{
            nowNumber += 1
            answerLabel.text = ""
            
            //次の問題を表示するか
            if nowNumber < shuffledWordArray.count {
                //次の問題を表示
                questionLabel.text = shuffledWordArray[nowNumber]["english"]
                //isAnswerdをfalseにする
                isAnswered = false
                //ボタンのタイトルを変更する
                nextButton.setTitle("答えを表示", for: .normal)
            } else {
                //これ以上表示する問題がないのでfinishビューに！
                self.performSegue(withIdentifier: "toFinishView", sender:nil)
            }
        } else{
            //答えを表示する
            answerLabel.text = shuffledWordArray[nowNumber]["japanese"]
            //isAnswerをtrueにする
            isAnswered = true
            //ボタンのタイトルを変更する
            nextButton.setTitle("次へ", for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
