//
//  MovieTableViewCell.swift
//  SeSAC4Task
//
//  Created by 차지용 on 7/23/25.
//

import UIKit
import Alamofire

class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    let movie = Movie.self
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getMovieData(index: Int, yearDate: Int) {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=e4585261643a6792f70ec61f206790a7&targetDt=\(yearDate)"
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                self.titleLable.text = value.boxOfficeResult.dailyBoxOfficeList[index].movieNm
                self.dateLabel.text = value.boxOfficeResult.dailyBoxOfficeList[index].openDt
                self.numberLabel.text = value.boxOfficeResult.dailyBoxOfficeList[index].rank
                
            case .failure(let value):
                print("데이터 불러오기 실패: \(value)")
            }
        }
    }
    func movieLayout() {
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.centerX.equalTo(contentView)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
}
extension MovieTableViewCell: DesignProtocol {
    func configure() {
        contentView.backgroundColor = .black
        contentView.addSubview(numberLabel)
        contentView.addSubview(titleLable)
        contentView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(numberLabel.snp.trailing).offset(15)
            make.width.equalTo(240)
            make.height.equalTo(30)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(30)
            
        }
    }
    
    
}
