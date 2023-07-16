

import Foundation
import UIKit
import SnapKit
import SDWebImage

class MovieViewController: UIViewController {
    
    var presenter: MoviePresentation?
    var movies: [Movie]?
    var genres: [Genre]?
    var collectionViewMovieList: UICollectionView!
    var collectionViewGenre: UICollectionView!
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Halo, Agung"
        
        return label
    }()
    
    var mottoLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "What movie you watch today?"
        
        return label
    }()
    
    var userImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "ic_user")
        imageview.contentMode = .scaleToFill
        
        return imageview
    }()
    
    var genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .gray
        label.text = "Genre"
        
        return label
    }()
    
    var listMovieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .gray
        label.text = "List Movie"
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getMovies()
        getGenres()
    }
    
    private func setupView() {
        let cvFlowLayoutGenres = UICollectionViewFlowLayout()
        cvFlowLayoutGenres.scrollDirection = .horizontal
        
        view.backgroundColor = .white
        view.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(100)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userImage)
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(userImage.snp.left)
        }
        
        view.addSubview(mottoLabel)
        mottoLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(userImage.snp.left)
        }
        
        view.addSubview(genreLabel)
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        collectionViewGenre = UICollectionView(frame: .zero, collectionViewLayout: cvFlowLayoutGenres)
        collectionViewGenre.translatesAutoresizingMaskIntoConstraints = false
        collectionViewGenre.showsHorizontalScrollIndicator = false
        view.addSubview(collectionViewGenre)
        collectionViewGenre.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
        }
        
        view.addSubview(listMovieLabel)
        listMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionViewGenre.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
        }
        
    
        collectionViewMovieList = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewMovieList.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionViewMovieList)
        collectionViewMovieList.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview()
            make.top.equalTo(listMovieLabel.snp.bottom).offset(10)
        }
        
        collectionViewGenre.dataSource = self
        collectionViewGenre.delegate = self
        collectionViewGenre.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        collectionViewGenre.backgroundColor = .white
        
        collectionViewMovieList.dataSource = self
        collectionViewMovieList.delegate = self
        collectionViewMovieList.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionViewMovieList.alwaysBounceVertical = true
        collectionViewMovieList.backgroundColor = .white
    }
    
    private func getMovies() {
        presenter?.getMovies()
    }
    
    private func getGenres() {
        presenter?.getGenres()
    }
}

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewMovieList {
            return self.movies?.count ?? 0
        } else {
            return self.genres?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewMovieList {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
            if let data = self.movies?[indexPath.item] {
                if let imageUrl = URL(string: Constants.URL_IMAGE + data.poster_path ){
                    cell.movieImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Loading_Thumbnail"), options: .highPriority, completed: nil)
                }
                cell.titleLabel.text = data.title
                cell.ratingLabel.text = String(data.vote_average.rounded())
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as! GenreCell
            if let data = self.genres?[indexPath.item] {
                cell.backgroundColor = .systemPurple
                cell.layer.masksToBounds = true
                cell.layer.cornerRadius = 10
                cell.layer.borderColor = UIColor.purple.cgColor
                cell.layer.borderWidth = 1
                
                cell.titleLabel.text = data.name
            }
            
            return cell
        }
        
    }
}

extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionViewGenre {
            if let data = self.genres?[indexPath.item] {
                presenter?.toGenreVC(genre: data)
            }
        } else {
            if let data = self.movies?[indexPath.item] {
                presenter?.toDetailMovie(movieId: data.id)
            }
        }
    }
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        if collectionView == collectionViewMovieList {
            return CGSize(width: (width - 15)/2, height: 300)
        } else {
            return CGSize(width: 150, height: 50)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == collectionViewMovieList {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionViewMovieList {
            return 5
        } else {
            return 2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionViewMovieList {
            return 5
        } else {
            return 2
        }
       
    }
}

extension MovieViewController: MovieView {
    func successGetGenres(data: [Genre]?) {
        self.genres = data
        collectionViewGenre.reloadData()
    }
    
    func successGetMovies(data: [Movie]?) {
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

