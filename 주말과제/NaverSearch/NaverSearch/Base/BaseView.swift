//
//  BaseView.swift
//  NaverSearch
//
//  Created by 차지용 on 7/28/25.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureLayout()
        configureView()
    }
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() { }
    func configureLayout() { }
    func configureView() { }
}
