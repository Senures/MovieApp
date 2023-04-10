//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by SEMANUR ESERLER on 2.04.2023.
//

import UIKit
import Kingfisher


protocol HomeViewControllerProtocol : AnyObject {
 //protocolleri weaki sadece classlara uygulanması gerekiyo,structlara değil.
    func setupUI()
    func collectionViewSet()
    func reloadCollectionView()
}


final class HomeViewController: UIViewController, HomeViewControllerProtocol {
    
    private lazy var  viewModel = HomeViewModel()
    
    
    
    let categoriList = ["Populars", "Coming Soon", "Top Rating", "Comedy", "Action","Fantastic","Drama","Anime"]
    

    
    @IBOutlet weak var popularCView: UICollectionView!
    @IBOutlet weak var categoriesCView: UICollectionView!
    
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        //view modelın delegate
        viewModel.viewDidLoad()
       
    
    }
    
    //MARK : Uygulamadaki view ve collectionvieların arka plan rengi verildi
    func  setupUI(){
        view.backgroundColor = .black
      //  titleView.backgroundColor = hexStringToUIColor(hex: "#1E1D1D")
        titleView.backgroundColor = UIColor(named: "lightGray")
       // categoriesCView.backgroundColor = hexStringToUIColor(hex: "#1E1D1D")
        categoriesCView.backgroundColor = .lightGray
        popularCView.backgroundColor = .black
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
    
    func reloadCollectionView() {
        
        DispatchQueue.main.async {
            self.popularCView.reloadData()
        }
        //reload ile ui yenileniyor güncel tutuyor o yüzden main threadde olmasını sağlıyor
    }
    
    
    
    @IBAction func searchButton(_ sender: Any) {
        print("search sayfasına gitmeliiiiiiii")
        self.performSegue(withIdentifier:"goSearch", sender:nil)
    }
    
}




extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCView {
            return categoriList.count
            // collectionView1 için veri sayısını döndürün
        } else if collectionView == popularCView {
            return self.viewModel.results?.count ?? 8
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
            cell.popularMovieName.text = self.viewModel.results?[indexPath.row].title
            var img = self.viewModel.results?[indexPath.row].backdropPath
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + (img ?? ""))
           
            cell.popularImg.kf.setImage(with: url)
            cell.backgroundColor = hexStringToUIColor(hex: "#1E1D1D")
            cell.layer.cornerRadius = 10
            let date = self.viewModel.results?[indexPath.row].releaseDate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let parsedDate = dateFormatter.date(from: date ?? "") {
                let year = Calendar.current.component(.year, from: parsedDate)
                cell.movDate.text = "(\(String(year)))"
                
            }
            let stringNumber = String(self.viewModel.results?[indexPath.row].voteAverage ?? 7.2)
            cell.vote.text = stringNumber
            
          
            return cell
           
        }
        return UICollectionViewCell()
    }
    
   
    //TIKLANDIGINDA VERİYİ GÖNDERİCEM MODELİ GÖNDERCEM
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == popularCView {
           
            if let data = self.viewModel.results?[indexPath.row].id {
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






extension HomeViewController: UICollectionViewDelegateFlowLayout {
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





