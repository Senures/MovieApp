//
//  ApiClient.swift
//  MoviesApp
//
//  Created by SEMANUR ESERLER on 3.04.2023.
//

import Foundation
import Alamofire


class ApiClient{
    
    static let apiClient = ApiClient()
    
    init() {
        print("apiclient calıstıııı")
    }
    
    
    
    func fetchPopularMovies(succesData: @escaping (PopularMoviesModel) -> Void)  {
        
     
        let baseUrl = "https://api.themoviedb.org/3/movie/popular?api_key=eb2dfe5fb23e1bdcd3dbf005750c38be&language=en-US&page=1"
        print(baseUrl)
        
        
        AF.request(baseUrl, method:.get, encoding:JSONEncoding.default, headers: nil, interceptor: nil).response{
            (responseData) in
            
            guard let data = responseData.data else { return }
            
            
            do{
              
                let data = try JSONDecoder().decode(PopularMoviesModel.self, from: data)
               
                succesData(data)
              
                
            } catch {
                print(data)
                print("catch bloğu")
            }
            
            
            
        }
    }
    
    
    func fetchMovieDetail(params:Int, succesData: @escaping (Welcome) -> Void)  {
        
       
        let baseUrl = String(format: "%@%@%@","https://api.themoviedb.org/3/movie/", String(params),"?api_key=eb2dfe5fb23e1bdcd3dbf005750c38be&language=en-US")
        //string birleştirme
        AF.request(baseUrl, method:.get, encoding:JSONEncoding.default, headers: nil, interceptor: nil).response{
            (responseData) in
        
            guard let data = responseData.data else { return }
            
            
            do{
                print(baseUrl)
                let data = try JSONDecoder().decode(Welcome.self, from: data)
                succesData(data)
                debugPrint(data)
                
            } catch {
            
                print("catch bloğu")
            }
            
            
            
        }
    }
    
    
    func fetchSeacrhMovies(search:String, succesData: @escaping (PopularMoviesModel) -> Void)  {
        
        print("fetchhhhhh search")
        print(search)
     
   
        let baseUrl = String(format: "%@%@%@","https://api.themoviedb.org/3/search/movie?api_key=eb2dfe5fb23e1bdcd3dbf005750c38be&language=en-US&query=", search,"&page=1&include_adult=false")
        //string birleştirme
        AF.request(baseUrl, method:.get, encoding:JSONEncoding.default, headers: nil, interceptor: nil).response{
            (responseData) in
        
            guard let data = responseData.data else { return }
            
            
            do{
                print(baseUrl)
                let data = try JSONDecoder().decode(PopularMoviesModel.self, from: data)
                succesData(data)
                debugPrint(data)
                
            } catch {
                print(data)
                print("catch bloğu")
            }
            
            
            
        }
    }
    
    
    
}
