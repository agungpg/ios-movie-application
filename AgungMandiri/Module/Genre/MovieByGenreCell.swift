
import UIKit

class MovieByGenreCell: UICollectionViewCell {
    
    static var identifier: String = "MovieByGenreCell"
    
    var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 16
        
        return image
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
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
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textColor = .darkGray
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(movieImage)
        movieImage.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(250)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(35)
        }
        
        self.addSubview(ratingImage)
        ratingImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalToSuperview()
            make.size.equalTo(20)
            make.bottom.equalToSuperview()
        }
        
        self.addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(ratingImage)
            make.left.equalTo(ratingImage.snp.right).offset(5)
            make.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
