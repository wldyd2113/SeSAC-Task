//
//  SearchDetailViewModel.swift
//  NaverSearch
//
//  Created by 차지용 on 8/12/25.
//

import Foundation

final class SearchDetailViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        var searchText: Obserable<String> = Obserable("") //검색값
        var searchData: Obserable<Void> = Obserable(())
    }
    
    struct Output {
        var searchData: Obserable<[ShopInfo]> = Obserable([])
        var macData: Obserable<[ShopInfo]> = Obserable([])
        var shopData: Obserable<[Shopdata]> = Obserable([]) // Shopdata를 저장할 프로퍼티
        var mac: Obserable<[Shopdata]> = Obserable([]) // Shopdata를 저장할 프로퍼티

        var total: Obserable<String> = Obserable("")
        var shopTotal: Obserable<ShopInfo?> = Obserable(nil)
    }

    var start = 1


    init() {
        input = Input()
        output = Output()
        input.searchData.bind {
            self.shopData(self.input.searchText.value)
            self.shopMacData()
        }
    }
    
    func  sortAccuracy() {
        output.shopData.value.removeAll()
        start = 1
        sortData(sort: NaverURL.sim.rawValue)
    }
    
    func sortDay() {
        output.shopData.value.removeAll()
        start = 1
        sortData(sort: NaverURL.date.rawValue)
    }
    
    func sortPriceUp() {
        output.shopData.value.removeAll()
       start = 1
       sortData(sort: NaverURL.dsc.rawValue)
   }
    
    func sortPriceDown() {
        output.shopData.value.removeAll()
       start = 1
       sortData(sort:  NaverURL.asc.rawValue)
   }
    
    private func sortData(sort: String) {
        NetworkManger.shared.shopData(self.input.searchText.value, sort: sort, start: start) { value in
            self.output.shopData.value.append(contentsOf: value.items)
            self.output.searchData.value = [value]
        } fail: { _ in
            print("실패")
        }

    }
    
   private func shopData(_ searchTitle: String, sort: String = NaverURL.sim.rawValue) {
        print(#function)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
       NetworkManger.shared.shopData(self.input.searchText.value, sort: NaverURL.sim.rawValue, start: start) { value in
           self.output.searchData.value = [value]
           self.output.shopData.value.append(contentsOf: value.items)
           self.output.total.value = "\(numberFormatter.string(for: value.total)!) 개의 검색 결과"
           self.output.shopTotal.value = value
            
            print("start", self.start)
            
        } fail: {_ in
            print("실패")
        }
        
    }
    
    private func shopMacData(sort: String = NaverURL.sim.rawValue) {
        NetworkManger.shared.shopMacData(start: start) { value in
            self.output.mac.value.append(contentsOf: value.items)
            self.output.macData.value = [value]
        } fail: {
            print("실패")
            
        }
    }
}
