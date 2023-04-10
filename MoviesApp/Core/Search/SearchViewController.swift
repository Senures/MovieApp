//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by SEMANUR ESERLER on 6.04.2023.
//

import UIKit
protocol SearchViewControllerProtocol : AnyObject {
 //protocolleri weaki sadece classlara uygulanması gerekiyo,structlara değil.
    func setupUI()
    func collectionViewSet()
    func reloadCollectionView()
}


final class SearchViewController: UIViewController, UITextFieldDelegate, SearchViewControllerProtocol {
    
    
    var search : String = "avatar"
    
    func setupUI() {
        
        searchTextfield.beginFloatingCursor(at: CGPoint(x: 20.0, y: 10.0))
        searchTextfield.endFloatingCursor()
        view.backgroundColor = .black
        searchTextfield.backgroundColor = hexStringToUIColor(hex: "#1E1D1D")
        searchCview.backgroundColor = .black
        searchTextfield.attributedPlaceholder = NSAttributedString(
            string: "  find movie",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
       
        
        searchTextfield.resignFirstResponder()
        searchCview.collectionViewLayout =
        UICollectionViewFlowLayout()
    }
    
    func collectionViewSet() {
        searchCview.dataSource = self
        searchCview.delegate = self
        searchTextfield.delegate = self
    }
    
    func reloadCollectionView() {
        
        DispatchQueue.main.async {
            self.searchCview.reloadData()
        }
        //reload ile ui yenileniyor güncel tutuyor o yüzden main threadde olmasını sağlıyor
    }
    
    
    let viewModel = SearchViewModel()
    
    
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var searchCview: UICollectionView!
    @IBOutlet weak var appBarTitle: UILabel!
    
    
  
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        //view modelın delegate
        viewModel.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           print("----------0")
           textField.resignFirstResponder()
           search(text: textField.text)
           print("----------1")
           return true
       }
       
       func search(text: String?) {
           print("----------2")
           if let deneme = text {
               
               self.search = deneme
               print(self.search)
               let searchText = self.search
               
               viewModel.apiCall(search: search)
               
        
               
           }
           
           
       }
    
    
   
    
    
}



extension SearchViewController :UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.searchList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCview.dequeueReusableCell(withReuseIdentifier:"searchCell", for: indexPath) as! SearchCell
        cell.searchName.text = self.viewModel.searchList?[indexPath.row].title
        cell.backgroundColor = hexStringToUIColor(hex: "#1E1D1D")
        cell.layer.cornerRadius = 10
       
        var img = self.viewModel.searchList?[indexPath.row].backdropPath
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + (img ?? ""))
         
         cell.movImg.kf.setImage(with: url)
        let date = self.viewModel.searchList?[indexPath.row].releaseDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let parsedDate = dateFormatter.date(from: date ?? "") {
            let year = Calendar.current.component(.year, from: parsedDate)
            cell.movYear.text = "(\(String(year)))"
            
        }
        let stringNumber = self.viewModel.searchList?[indexPath.row].voteAverage ?? 7.2
        let vote = String(format: "%.1f", stringNumber)
        cell.movVote.text = String(stringNumber)
        return cell
    }
    
    //TIKLANDIGINDA VERİYİ GÖNDERİCEM MODELİ GÖNDERCEM
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        if let data = self.viewModel.searchList?[indexPath.row].id {
            print(data)
            self.performSegue(withIdentifier:"goDetail", sender: data)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
}
