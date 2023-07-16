

import Foundation

import Foundation
import UIKit
import SnapKit
import SDWebImage

class GenreViewController: UIViewController {
    
    var presenter: GenrePesentation?
    var movies: [Movie]?
    var genre: Genre?
    var collectionViewMovieList: UICollectionView!
    
    var genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    var buttonBack: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_back"), for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getMoviesByGenre()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupView() {
        let cvFlowLayoutGenres = UICollectionViewFlowLayout()
        cvFlowLayoutGenres.scrollDirection = .horizontal
        
        view.backgroundColor = .white
        
        view.addSubview(genreLabel)
        genreLabel.text = genre?.name
        genreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(15)
        }
        
        view.addSubview(buttonBack)
        buttonBack.addTarget(self, action: #selector(goBack) , for: .touchUpInside)
        buttonBack.snp.makeConstraints { make in
            make.top.equalTo(genreLabel).offset(20)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(30)
        }
    
        collectionViewMovieList = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewMovieList.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionViewMovieList)
        collectionViewMovieList.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview()
            make.top.equalTo(buttonBack.snp.bottom).offset(10)
        }
        
        collectionViewMovieList.dataSource = self
        collectionViewMovieList.delegate = self
        collectionViewMovieList.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionViewMovieList.alwaysBounceVertical = true
        collectionViewMovieList.backgroundColor = .white
    }
    
    private func getMoviesByGenre() {
        presenter?.getMoviesByGenre(genreId: genre?.id ?? 0)
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension GenreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = self.movies?[indexPath.item] {
            presenter?.toDetailMovie(movieId: data.id)
        }
    }
}

extension GenreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        if let data = self.movies?[indexPath.item] {
            if let imageUrl = URL(string: Constants.URL_IMAGE + data.poster_path ){
                cell.movieImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Loading_Thumbnail"), options: .highPriority, completed: nil)
            }
            cell.titleLabel.text = data.title
            cell.ratingLabel.text = String(data.vote_average.rounded())
        }
        return cell
    }
}

extension GenreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: (width - 15)/2, height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
       
    }
}

extension GenreViewController: GenreView {
    func successGetMoviesByGenre(data: [Movie]?) {
        self.movies = data
        collectionViewMovieList.reloadData()
    }
    
    func showLoading() {
        Helper.starLoading(view: self.view)
    }
    
    func hideLoading() {
        Helper.stopLoading()
    }
    
    func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    
    
}


