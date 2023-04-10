//
//  SearchViewModel.swift
//  MoviesApp
//
//  Created by SEMANUR ESERLER on 9.04.2023.
//

import Foundation


protocol SearchViewModelProtocol {
    
    var view : SearchViewControllerProtocol? { get set }
    //protocolün icine yazdıgın degiskenleri get ve set ile tanımlamak zorundasın, get zorunlu set keyfi
    
    func viewDidLoad()
    func apiCall(search:String)
}

final class SearchViewModel : SearchViewModelProtocol {
  
    
    
    weak var view:  SearchViewControllerProtocol?
   
    var searchList : [Result]?
    
   
    
    func viewDidLoad() {
        view?.setupUI()
        
        view?.collectionViewSet()
    }
    
    
    
    func apiCall(search:String){
        
        ApiClient.apiClient.fetchSeacrhMovies(search: search ?? "a"){ response in
            
            self.searchList = response.results
            
            self.view?.reloadCollectionView()
            
        }
        
    }
    
    
}
