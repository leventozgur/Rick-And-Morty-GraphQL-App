//
//  HomeTableViewCell.swift
//  digieggs-assessment
//
//  Created by Levent ÖZGÜR on 11.03.22.
//

import UIKit
import AlamofireImage
import SwiftUI

class HomeTableViewCell: UITableViewCell {

    private let cardView: UIView = UIView()
    private let image: UIImageView = UIImageView()
    private let id: UILabel = UILabel()
    private let name: UILabel = UILabel()
    private let location: UILabel = UILabel()
    
    private let dummyImage: String = ImageEnum.rickyMortyPlaceholderImage.rawValue
    
    enum Identifier: String {
        case custom = "homeTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewConfigurations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func viewConfigurations() {
        addSubview(cardView)
        addSubview(image)
        addSubview(id)
        addSubview(name)
        addSubview(location)
        
        drawCardView()
        drawImage()
        drawId()
        drawName()
        drawLocation()
        
        DispatchQueue.main.async {
            //Figmadaki hali bu, ama kötü durduğu için kapatıldı.
            //self.image.contentMode = .scaleAspectFill
            self.id.font.withSize(16)
            self.name.font.withSize(16)
            self.location.font.withSize(16)
            self.backgroundColor = .clear
            self.setCardViewSettings()
        }
    }
    
    func saveModel(model: CharacterData.Result) {
        image.af.setImage(withURL: URL(string: model.image ?? dummyImage) ?? URL(string: dummyImage)!)
        id.attributedText = NSMutableAttributedString().bold("#id: ").normal(model.id ?? "")
        name.attributedText = NSMutableAttributedString().bold("Name: ").normal(model.name ?? "")
        if let locationData = model.location {
            location.attributedText = NSMutableAttributedString().bold("Location: ").normal(locationData.name ?? "")
        }
    }
    
    private func setCardViewSettings() {
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        cardView.layer.shadowRadius = 6.0
        cardView.layer.shadowOpacity = 0.2
        
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

//MARK: - Snapkit View features
extension HomeTableViewCell {
    func drawCardView() {
        cardView.snp.makeConstraints { make in
            make.height.equalTo(265)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
    }
    
    func drawImage() {
        image.snp.makeConstraints { make in
            make.height.equalTo(168)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
    }
    
    func drawId() {
        id.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(8)
            make.right.equalToSuperview().offset(-41)
            make.height.greaterThanOrEqualTo(16)
        }
    }
    
    func drawName() {
        name.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(35)
            make.left.equalToSuperview().offset(38)
            make.height.greaterThanOrEqualTo(16)
        }
    }
    
    func drawLocation() {
        location.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(8)
            make.left.equalTo(name.snp.left)
            make.height.greaterThanOrEqualTo(16)
        }
    }
}


extension NSMutableAttributedString {
    var fontSize:CGFloat { return 16 }
    var boldFont:UIFont { return .boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return .systemFont(ofSize: fontSize)}
    
    func bold(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}

