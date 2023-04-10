//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by SEMANUR ESERLER on 8.04.2023.
//

import Foundation


protocol HomeViewModelProtocol {
    
    var view : HomeViewControllerProtocol? { get set }
    //protocolün icine yazdıgın degiskenleri get ve set ile tanımlamak zorundasın, get zorunlu set keyfi
    
    func viewDidLoad()
    func apiCall()
}

final class HomeViewModel : HomeViewModelProtocol {
    
    
    
   weak var view: HomeViewControllerProtocol?
   //weak class olmayan yapılara uygulanmamalı sebebi
   //
  //işci sınıfını gücsüz tanımlıyoruz
    var results : [Result]?
    
    func viewDidLoad() {
        
        view?.setupUI()
        apiCall()
        view?.collectionViewSet()
        
    }
    
    
    func  apiCall(){
        ApiClient.apiClient.fetchPopularMovies { response in
         self.results = response.results
            print("ssssssss \(String(describing: self.results?[0].originalTitle))")
            self.view?.reloadCollectionView()
           //viewa protocol üzerimnden erisiyoruz ondan reload controller protocolunde yazdık
        }
    }
    
    
    
    //amac viewı yönetmek
    
    
}
