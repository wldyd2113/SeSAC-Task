//
//  threeSixNineViewController.swift
//  SeSACTravel
//
//  Created by 차지용 on 7/12/25.
//

import UIKit

class threeSixNineViewController: UIViewController {
    
    @IBOutlet var userTextFiled: UITextField!
    
    @IBOutlet var resultText: UITextView!
    @IBOutlet var countLabel: UILabel!
    var resultCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        resultText.text = " "
        resultText.isEditable = false
        resultText.textAlignment = .center
        
        countLabel.textAlignment = .center
        countLabel.font = .systemFont(ofSize: 20, weight: .bold)
        countLabel.numberOfLines = 0
    }
    
    func alertMessage() {
        let alert = UIAlertController(title: "문자 입력 오류", message: "숫자를 입력해주세요", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        present(alert, animated: true)
        alert.addAction(ok)
    }
    
    
    
    @IBAction func returnTextField(_ sender: UITextField) {
        
        guard let userTextFiled = userTextFiled.text else { return }
        if let intTextFiled = Int(userTextFiled)  {
            resultText.text = ""
            for i in 1 ... intTextFiled { 
                if String(i).contains(String("3")) || String(i).contains(String("6")) || String(i).contains(String("9")) {
                    resultText.text += "👏 "
                }
                else {
                    resultText.text += "\(i) "
                }
            }
        }
        else {
            alertMessage()
        }
        resultCount = resultText.text.ranges(of: "👏").count
            countLabel.text = "숫자 \(userTextFiled)까지 총 박수는\n \(resultCount)번 입니다"
        
    }
}
