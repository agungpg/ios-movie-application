

import Foundation
import UIKit

class DetailMovieViewController: UIViewController {
    
    var presenter: DetailMoviePresentation?
    var movieId: Int = 0
    var detailMovie: DetailMovieResponse?
    var reviews: ReviewResponse?
    var collectionViewGenre: UICollectionView!
    let tabs = ["Detail", "Reviews", "Trailer"]
    var buttonTabs = [UIButton]()
    
    var movieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    var buttonBack: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_back"), for: .normal)
        
        return button
    }()
    
    var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 16
        
        return image
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    var ratingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_rating")
        return image
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        
        return label
    }()
    
    var calendarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_calendar")
        return image
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        
        return label
    }()
    
    var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "Overview"
        
        return label
    }()
    
    var overviewValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 10
        label.sizeToFit()
        
        return label
    }()
    
    var svDetail: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.alignment = .fill
        stackview.spacing = 5
        return stackview
    }()
    
    var imageYT: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "ic_youtube")
        imageview.contentMode = .scaleAspectFill
        imageview.isHidden = true
        
        return imageview
    }()
    
    var imageTrailer: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.isHidden = true
        
        return imageview
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getDetailMovie()
        getReviews()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        view.addSubview(buttonBack)
        buttonBack.addTarget(self, action: #selector(goBack) , for: .touchUpInside)
        buttonBack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(30)
        }
        
        view.addSubview(movieLabel)
        movieLabel.snp.makeConstraints { make in
            make.centerY.equalTo(buttonBack)
            make.left.equalTo(buttonBack.snp.right).offset(15)
        }
        
        view.addSubview(movieImage)
        movieImage.snp.makeConstraints { make in
            make.top.equalTo(movieLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(250)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(calendarImage)
        calendarImage.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(5)
            make.left.equalTo(movieImage.snp.left).offset(7)
            make.size.equalTo(20)
        }
        
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(calendarImage)
            make.left.equalTo(calendarImage.snp.right).offset(2)
        }
        
        view.addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { make in
            make.right.equalTo(movieImage.snp.right).offset(-7)
            make.top.equalTo(movieImage.snp.bottom).offset(5)
        }
        
        view.addSubview(ratingImage)
        ratingImage.snp.makeConstraints { make in
            make.right.equalTo(ratingLabel.snp.left).offset(-2)
            make.centerY.equalTo(ratingLabel)
            make.size.equalTo(20)
        }
        
        view.addSubview(svDetail)
        svDetail.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(45)
        }
        for (index, type) in tabs.enumerated() {
            let btn = UIButton()
            btn.tag = index
            btn.setTitle(type, for: .normal)
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 10
            btn.setTitleColor(.black, for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            btn.addTarget(self, action: #selector(switchTab(_:)), for: .touchUpInside)
            
            svDetail.addArrangedSubview(btn)
            buttonTabs.append(btn)
        }
        buttonTabs[0].backgroundColor = .lightGray
        
        let cvFlowLayoutGenres = UICollectionViewFlowLayout()
        cvFlowLayoutGenres.scrollDirection = .horizontal
        collectionViewGenre = UICollectionView(frame: .zero, collectionViewLayout: cvFlowLayoutGenres)
        collectionViewGenre.translatesAutoresizingMaskIntoConstraints = false
        collectionViewGenre.showsHorizontalScrollIndicator = false
        view.addSubview(collectionViewGenre)
        collectionViewGenre.snp.makeConstraints { make in
            make.top.equalTo(svDetail.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
        }
        
        view.addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionViewGenre.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
        }
        
        view.addSubview(overviewValueLabel)
        overviewValueLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        view.addSubview(imageTrailer)
        imageTrailer.snp.makeConstraints { make in
            make.top.equalTo(svDetail.snp.bottom).offset(30)
            make.width.equalTo(view.frame.width/1.5)
            make.centerX.equalToSuperview()
            make.height.equalTo(300)
        }
        
        view.addSubview(imageYT)
        imageYT.snp.makeConstraints { make in
            make.center.equalTo(imageTrailer)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        collectionViewGenre.dataSource = self
        collectionViewGenre.delegate = self
        collectionViewGenre.register(DetailGenreCell.self, forCellWithReuseIdentifier: DetailGenreCell.identifier)
        collectionViewGenre.backgroundColor = .white
    }
    
    @objc private func switchTab(_ sender: UIButton) {
        self.buttonTabs.forEach { (button) in
            if (button === sender) {
                button.backgroundColor = .lightGray
            } else {
                button.backgroundColor = .clear
            }
        }
        
        switch sender.tag {
        case 0:
            overviewLabel.text = "Overview"
            overviewValueLabel.text = detailMovie?.overview
            imageYT.isHidden = true
            imageTrailer.isHidden = true
            collectionViewGenre.isHidden = false
            overviewLabel.isHidden = false
            overviewValueLabel.isHidden = false
        case 1:
            if let data = reviews?.results.first {
                overviewValueLabel.text = ("\(data.author) => \(data.content)")
            }
            overviewLabel.text = "Review"
            imageYT.isHidden = true
            imageTrailer.isHidden = true
            collectionViewGenre.isHidden = true
            overviewLabel.isHidden = false
            overviewValueLabel.isHidden = false
        case 2:
            imageYT.isHidden = false
            imageTrailer.isHidden = false
            collectionViewGenre.isHidden = true
            overviewLabel.isHidden = true
            overviewValueLabel.isHidden = true
        default:
            break
        }
        
    }
    
    private func getDetailMovie() {
        presenter?.getDetailMovie(movieId: movieId)
    }
    
    private func getReviews() {
        presenter?.getReviews(movieId: movieId)
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupData(data: DetailMovieResponse?) {
        self.detailMovie = data
        if let detailMovie = data {
            if let imageUrl = URL(string: Constants.URL_IMAGE + (detailMovie.backdrop_path) ){
                movieImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Loading_Thumbnail"), options: .highPriority, completed: nil)
                imageTrailer.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Loading_Thumbnail"), options: .highPriority, completed: nil)
            }
            movieLabel.text = detailMovie.title
            ratingLabel.text = String(detailMovie.vote_average.rounded())
            dateLabel.text = data?.release_date
            overviewValueLabel.text = data?.overview
        }
        collectionViewGenre.reloadData()
    }
    
    
}

extension DetailMovieViewController: DetailMovieView {
    func successGetReviews(data: ReviewResponse?) {
        reviews = data
    }
    
    func successGetDetailMovie(data: DetailMovieResponse?) {
        setupData(data: data)
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

extension DetailMovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.detailMovie?.genres.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailGenreCell.identifier, for: indexPath) as! DetailGenreCell
        if let data = self.detailMovie?.genres[indexPath.item] {
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

extension DetailMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
       
    }
}


