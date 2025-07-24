//
//  MovieViewController.swift
//  SeSAC4Task
//
//  Created by 차지용 on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire
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
    let movieTitle1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    let rnak1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    let movieDate1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    let movieTitle2: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    let rnak2: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    let movieDate2: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    let movieTitle3: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    let rnak3: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    let movieDate3: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        return label
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
        getMovieData()
    }
    
    @objc func randomButtonTapped() {
        tableView.reloadData()
    }
    
    func getMovieData() {
        let yearDate = 20250723
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=e4585261643a6792f70ec61f206790a7&targetDt=\(yearDate)"
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                self.rnak1.text = "\(value.boxOfficeResult.dailyBoxOfficeList[0].rank)"
                self.movieTitle1.text = "\(value.boxOfficeResult.dailyBoxOfficeList[0].movieNm)"
                self.movieDate1.text = "\(value.boxOfficeResult.dailyBoxOfficeList[0].openDt)"

                self.rnak2.text = "\(value.boxOfficeResult.dailyBoxOfficeList[1].rank)"
                self.movieTitle2.text = "\(value.boxOfficeResult.dailyBoxOfficeList[1].movieNm)"
                self.movieDate2.text = "\(value.boxOfficeResult.dailyBoxOfficeList[1].openDt)"
                
                self.rnak3.text = "\(value.boxOfficeResult.dailyBoxOfficeList[2].rank)"
                self.movieTitle3.text = "\(value.boxOfficeResult.dailyBoxOfficeList[2].movieNm)"
                self.movieDate3.text = "\(value.boxOfficeResult.dailyBoxOfficeList[2].openDt)"
            case .failure(let value):
                print("데이터 불러오기 실패: \(value)")
            }
        }
    }
    func getMovieTextData(yearDate: Int) {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=e4585261643a6792f70ec61f206790a7&targetDt=\(yearDate)"
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                self.rnak1.text = "\(value.boxOfficeResult.dailyBoxOfficeList[0].rank)"
                self.movieTitle1.text = "\(value.boxOfficeResult.dailyBoxOfficeList[0].movieNm)"
                self.movieDate1.text = "\(value.boxOfficeResult.dailyBoxOfficeList[0].openDt)"

                self.rnak2.text = "\(value.boxOfficeResult.dailyBoxOfficeList[1].rank)"
                self.movieTitle2.text = "\(value.boxOfficeResult.dailyBoxOfficeList[1].movieNm)"
                self.movieDate2.text = "\(value.boxOfficeResult.dailyBoxOfficeList[1].openDt)"
                
                self.rnak3.text = "\(value.boxOfficeResult.dailyBoxOfficeList[2].rank)"
                self.movieTitle3.text = "\(value.boxOfficeResult.dailyBoxOfficeList[2].movieNm)"
                self.movieDate3.text = "\(value.boxOfficeResult.dailyBoxOfficeList[2].openDt)"

            case .failure(let value):
                print("데이터 불러오기 실패: \(value)")
            }
        }
    }
}




extension MovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        view.endEditing(true)
        guard let yearText = Int(movieTextField.text ?? "0") else { return false }
        getMovieTextData(yearDate: yearText)
        print(getMovieTextData(yearDate: yearText))

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
        cell.getMovieData(index: indexPath.row, yearDate: 20250723)
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
        view.addSubview(rnak1)
        view.addSubview(movieTitle1)
        view.addSubview(movieDate1)
        view.addSubview(rnak2)
        view.addSubview(movieTitle2)
        view.addSubview(movieDate2)
        view.addSubview(rnak3)
        view.addSubview(movieTitle3)
        view.addSubview(movieDate3)
        
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
            make.width.equalTo(80)
        }
        rnak1.snp.makeConstraints { make in
            make.top.equalTo(movieTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        movieTitle1.snp.makeConstraints { make in
            make.top.equalTo(movieTextField.snp.bottom).offset(20)
            make.leading.equalTo(rnak1.snp.trailing).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(240)
        }
        movieDate1.snp.makeConstraints { make in
            make.top.equalTo(movieTextField.snp.bottom).offset(20)
            make.leading.equalTo(movieTitle1.snp.trailing).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        rnak2.snp.makeConstraints { make in
            make.top.equalTo(rnak1.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        movieTitle2.snp.makeConstraints { make in
            make.top.equalTo(rnak1.snp.bottom).offset(20)
            make.leading.equalTo(rnak2.snp.trailing).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(240)
        }
        movieDate2.snp.makeConstraints { make in
            make.top.equalTo(rnak1.snp.bottom).offset(20)
            make.leading.equalTo(movieTitle2.snp.trailing).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        rnak3.snp.makeConstraints { make in
            make.top.equalTo(rnak2.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        movieTitle3.snp.makeConstraints { make in
            make.top.equalTo(rnak2.snp.bottom).offset(20)
            make.leading.equalTo(rnak3.snp.trailing).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(240)
        }
        movieDate3.snp.makeConstraints { make in
            make.top.equalTo(rnak2.snp.bottom).offset(20)
            make.leading.equalTo(movieTitle3.snp.trailing).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(movieTextField.snp.bottom).offset(150)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
}
