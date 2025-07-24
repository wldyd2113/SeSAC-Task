//
//  MovieViewController.swift
//  SeSAC4Task
//
//  Created by 차지용 on 7/23/25.
//

import UIKit
import SnapKit

class MovieViewController: UIViewController {
    
    var movie = Movie.self
    let movieTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "영화를 검색해주세요"
        textField.textColor = .black
        textField.borderStyle = .line
        textField.keyboardType = .default
        textField.backgroundColor = .white
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let tableView: UITableView = {
        let tabelView = UITableView()
        tabelView.backgroundColor = .black
        return tabelView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureLayout()
    }
    
    @objc func randomButtonTapped() {
//        movie = movie.shuffled()
        tableView.reloadData()
    }

}

extension MovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        view.endEditing(true)
//        movie = movie.shuffled()
        tableView.reloadData()
        
        return true
    }
}

//MARK: TableView
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.getMovieData(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MovieViewController: DesignProtocol {
    func configure() {
        view.backgroundColor = .black
        view.addSubview(movieTextField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
        movieTextField.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    func configureLayout() {
        movieTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalTo(view).offset(15)
            make.height.equalTo(50)
            make.width.equalTo(250)
            
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalTo(movieTextField.snp.trailing).offset(15)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(movieTextField.snp.bottom).offset(50)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
}
