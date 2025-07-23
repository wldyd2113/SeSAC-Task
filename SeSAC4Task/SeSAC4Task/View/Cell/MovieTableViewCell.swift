//
//  MovieTableViewCell.swift
//  SeSAC4Task
//
//  Created by 차지용 on 7/23/25.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    let movie = MovieInfo.movies
    
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
    
    func movieData(_ movie: Movie, index: Int) {
        titleLable.text = movie.title
        
        let dateString = movie.releaseDate
        
        if let date = UITableViewCell.firstDateExtension.date(from: dateString) {
            dateLabel.text = UITableViewCell.dateFormatterExtension.string(for: date)
            print("형변환 성공")
        }
        else {
            print("형변환 실패")
        }
        numberLabel.text = "\(index + 1)"

        
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
