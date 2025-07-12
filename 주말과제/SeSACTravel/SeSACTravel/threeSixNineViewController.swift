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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        resultText.text = " "
        resultText.isEditable = false
        resultText.textAlignment = .center
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
    }
}
