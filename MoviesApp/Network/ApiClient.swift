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
    
    init() {}
    
    func fetchPopularMovies(succesData: @escaping (PopularMoviesModel) -> Void)  {
        let queryList: [QueryList] = [QueryList(queryKey: "api_key", queryValue: Constants.apiKey),
        QueryList(queryKey: "language", queryValue: "en-US"),
        QueryList(queryKey: "page", queryValue: "1")]
        let baseUrl = createEndpoint(resourceKey: "movie/popular", list: queryList)
        
        ServiceManager.shared.fetch(path: baseUrl) { (response: PopularMoviesModel) in
            succesData(response)
        }
    }
    
    
    func fetchMovieDetail(params:Int, succesData: @escaping (Welcome) -> Void)  {
        let queryList: [QueryList] = [QueryList(queryKey: "api_key", queryValue: Constants.apiKey),
        QueryList(queryKey: "language", queryValue: "en-US")]
        let baseUrl = createEndpoint(resourceKey: String(format: "%@%@", "movie/", String(params)), list: queryList)
        
        ServiceManager.shared.fetch(path: baseUrl) { (response: Welcome) in
            succesData(response)
        }
    }
    
    
    func fetchSeacrhMovies(search:String, succesData: @escaping (PopularMoviesModel) -> Void)  {
        let queryList: [QueryList] =
            [QueryList(queryKey: "api_key", queryValue: Constants.apiKey),
            QueryList(queryKey: "language", queryValue: "en-US"),
            QueryList(queryKey: "query", queryValue: search),
            QueryList(queryKey: "page", queryValue: "1"),
            QueryList(queryKey: "include_adult", queryValue: "false")]
        let baseUrl = createEndpoint(resourceKey: "search/movie", list: queryList)
        ServiceManager.shared.fetch(path: baseUrl) { (response: PopularMoviesModel) in
            succesData(response)
        }
    }
    
    private func createEndpoint(resourceKey: String, list: [QueryList]) -> URL {
        var queryItems: [URLQueryItem] = []
        for item in list {
            queryItems.append(URLQueryItem(name: item.queryKey, value: item.queryValue))
        }
        let baseURL = String(format: "%@%@", Constants.baseURL, resourceKey)
        var urlComps = URLComponents(string: baseURL)!
        urlComps.queryItems = queryItems
        return urlComps.url!
    }
}

struct QueryList {
    var queryKey: String
    var queryValue: String
}
