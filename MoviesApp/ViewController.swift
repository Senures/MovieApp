//
//  ViewController.swift
//  MoviesApp
//
//  Created by SEMANUR ESERLER on 2.04.2023.
//

import UIKit
import Kingfisher

final class ViewController: UIViewController {
    
    
    let categoriList = ["Populars", "Coming Soon", "Top Rating", "Comedy", "Action","Fantastic","Drama","Anime"]
    
    var results : [Result]?
    @IBOutlet weak var popularCView: UICollectionView!
    @IBOutlet weak var categoriesCView: UICollectionView!
    
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUiColor()
        apiCall()
        collectionViewSet()
        
    
    }
    
    //MARK : Uygulamadaki view ve collectionvieların arka plan rengi verildi
    func  setUiColor(){
        view.backgroundColor = .black
      //  titleView.backgroundColor = hexStringToUIColor(hex: "#1E1D1D")
        titleView.backgroundColor = UIColor(named: "lightGray")
       // categoriesCView.backgroundColor = hexStringToUIColor(hex: "#1E1D1D")
        categoriesCView.backgroundColor = .lightGray
        popularCView.backgroundColor = .black
    }
    
    //MARK : apiyi cagırdıgım fonksiyon
    func  apiCall(){
        ApiClient.apiClient.fetchPopularMovies { response in
         self.results = response.results
            print("ssssssss \(String(describing: self.results?[0].originalTitle))")
            self.popularCView.reloadData()
            self.categoriesCView.reloadData()
        }
    }
    
    //MARK : delegate bağlama işlemleri
    func  collectionViewSet(){
        
        categoriesCView.dataSource = self
        categoriesCView.delegate = self
        
        
        popularCView.dataSource = self
        popularCView.delegate = self
        
        popularCView.collectionViewLayout =
        UICollectionViewFlowLayout()
    }
    
    
    
    @IBAction func searchButton(_ sender: Any) {
        print("search sayfasına gitmeliiiiiiii")
        self.performSegue(withIdentifier:"goSearch", sender:nil)
    }
    
}




extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCView {
            return categoriList.count
            // collectionView1 için veri sayısını döndürün
        } else if collectionView == popularCView {
            return results?.count ?? 8
            // collectionView2 için veri sayısını döndürün
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCView {
            let cell = categoriesCView.dequeueReusableCell(withReuseIdentifier: "categoriCell", for: indexPath) as! CategoriesCell
            cell.categoriLabel.text = categoriList[indexPath.row]
            cell.contentView.layer.cornerRadius = 25 
            cell.contentView.layer.masksToBounds = true
            cell.contentView.backgroundColor = .gray
            return cell
        } else if collectionView == popularCView {
            
            let cell = popularCView.dequeueReusableCell(withReuseIdentifier:"popularcell", for: indexPath) as! PopularMoviesCell
            cell.popularMovieName.text = results?[indexPath.row].title
            var img = results?[indexPath.row].backdropPath
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + (img ?? ""))
           
            cell.popularImg.kf.setImage(with: url)
            cell.backgroundColor = hexStringToUIColor(hex: "#1E1D1D")
            cell.layer.cornerRadius = 10
            let date = results?[indexPath.row].releaseDate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let parsedDate = dateFormatter.date(from: date ?? "") {
                let year = Calendar.current.component(.year, from: parsedDate)
                cell.movDate.text = "(\(String(year)))"
                
            }
            let stringNumber = String(results?[indexPath.row].voteAverage ?? 7.2)
            cell.vote.text = stringNumber
            
          
            return cell
           
        }
        return UICollectionViewCell()
    }
    
    
    
    //TIKLANDIGINDA VERİYİ GÖNDERİCEM MODELİ GÖNDERCEM
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == popularCView {
           
            if let data = results?[indexPath.row].id {
                self.performSegue(withIdentifier:"goDetail", sender: data)
            }
        }
        
        else {
            print("collection viewww  istediğim değilll")
        }
    }
    
    //DİĞER SAYFANIN CONTROLLERINDA  VERİYİ ALMAK İÇİN
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetail" {
            
            let dvc = segue.destination as? DetailViewController
            dvc?.movieId = sender as? Int
            
        }
    }
    
    
    
}






extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesCView {
            return CGSize(width: 150, height: 50)
        } else {
            return CGSize(width: 180, height: 280)
        }
        
       // return CGSize(width: 180, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == popularCView {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        } else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
         
        }
}





