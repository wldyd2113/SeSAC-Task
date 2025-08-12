//
//  SearchDetailViewModel.swift
//  NaverSearch
//
//  Created by 차지용 on 8/12/25.
//

import Foundation

final class SearchDetailViewModel {
    var inputSearchText: Obserable<String> = Obserable("") //검색값
    var inputSearchData: Obserable<Void> = Obserable(())
    var start = 1
    var outputSearchData: Obserable<[ShopInfo]> = Obserable([])
    var outputMacData: Obserable<[ShopInfo]> = Obserable([])
    var ouptputShopData: Obserable<[Shopdata]> = Obserable([]) // Shopdata를 저장할 프로퍼티
    var ouptputMac: Obserable<[Shopdata]> = Obserable([]) // Shopdata를 저장할 프로퍼티

    var outputTotal: Obserable<String> = Obserable("")
    var outputShopTotal: Obserable<ShopInfo?> = Obserable(nil)



    
    init() {
        inputSearchData.lazyBind {
            self.shopData(self.inputSearchText.value)
            self.shopMacData()
        }
    }
    

    
    
    func  sortAccuracy() {
        ouptputShopData.value.removeAll()
        start = 1
        sortData(sort: NaverURL.sim.rawValue)
    }
    
    func sortDay() {
        ouptputShopData.value.removeAll()
        start = 1
        sortData(sort: NaverURL.date.rawValue)
    }
    
    func sortPriceUp() {
       ouptputShopData.value.removeAll()
       start = 1
       sortData(sort: NaverURL.dsc.rawValue)
   }
    
    func sortPriceDown() {
       ouptputShopData.value.removeAll()
       start = 1
       sortData(sort:  NaverURL.asc.rawValue)
   }
    
    private func sortData(sort: String) {
        NetworkManger.shared.shopData(self.inputSearchText.value, sort: sort, start: start) { value in
            self.ouptputShopData.value.append(contentsOf: value.items)
            self.outputSearchData.value = [value]
        } fail: { _ in
            print("실패")
        }

    }
    
   private func shopData(_ searchTitle: String, sort: String = NaverURL.sim.rawValue) {
        print(#function)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        NetworkManger.shared.shopData(self.inputSearchText.value, sort: NaverURL.sim.rawValue, start: start) { value in
            self.outputSearchData.value = [value]
            self.ouptputShopData.value.append(contentsOf: value.items)
            self.outputTotal.value = "\(numberFormatter.string(for: value.total)!) 개의 검색 결과"
            self.outputShopTotal.value = value
            
            print("start", self.start)
            
        } fail: {_ in
//            self.alert(title: "통신 오류", message: "통신 오류가 발생했습니다", okMessage: "확인")
            print("실패")
        }
        
    }
    
    private func shopMacData(sort: String = NaverURL.sim.rawValue) {
        NetworkManger.shared.shopMacData(start: start) { value in
            self.ouptputMac.value.append(contentsOf: value.items)
            self.outputMacData.value = [value]
        } fail: {
//            self.alert(title: "통신 오류", message: "통신 오류가 발생했습니다", okMessage: "확인")
            print("실패")
            
        }
    }
}
