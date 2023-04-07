//
//  DetailViewController.swift
//  MoviesApp
//
//  Created by SEMANUR ESERLER on 5.04.2023.
//

import UIKit

final class DetailViewController: UIViewController {

   
    @IBOutlet weak var movDescription: UILabel!
    @IBOutlet weak var detailImg: UIImageView!
    
    @IBOutlet weak var detailVote: UILabel!
    @IBOutlet weak var movieIdLbl: UILabel!
    var movieId : Int?
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        view.backgroundColor = .black
        movDescription.sizeToFit()
        //bu önemliiii
        ApiClient.apiClient.fetchMovieDetail(params:movieId ?? 677179) { response in
            print("----------------------------")
            
            self.movieIdLbl.text = response.originalTitle
            
            let img = response.backdropPath
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + (img ?? ""))
           
            self.detailImg.kf.setImage(with: url)
           
            self.movDescription.text = response.overview
            let stringNumber = response.voteAverage ?? 7.2
            let vote = String(format: "%.1f", stringNumber)
            self.detailVote.text = vote
           
        }
        
        
        
       
        // Do any additional setup after loading the view.
    }
   
   
    
        
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
