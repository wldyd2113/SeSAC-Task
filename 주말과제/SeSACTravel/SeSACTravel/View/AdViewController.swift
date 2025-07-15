//
//  AdViewController.swift
//  SeSACTravel
//
//  Created by 차지용 on 7/15/25.
//

import UIKit

class AdViewController: UIViewController {

    @IBOutlet var titleText: UINavigationBar!
    @IBOutlet var AdLabel: UILabel!
    var ad = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        AdLabel.text = ad
        AdLabel.numberOfLines = 0
        AdLabel.textAlignment = .center
        AdLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)

    }
    

    @IBAction func xbuttonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
