//
//  RMCharacterCollectionViewCell.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 12.02.23.
//

import UIKit


/// Single cell for a character
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    
    static let cellIndentifier = "RMCharacterCollectionViewCell"
    
    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let statusLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16 ,weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
   // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(statusLabel,nameLabel,imageView)
        addConstraints()
        setupLayer()
    }
    
    
    
    func setupLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height:4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
              setupLayer()
        }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant:7),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant:-7),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant:7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant:-7),
            
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor,constant: -3),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
            
            
        ])
    }
       
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    
    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel) {
        
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage{ [weak self ]result   in
            switch result {
            case.success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case.failure(let error):
                print(String(describing: error ))
                break
            }
        }
        
        
        
    }
    
    
    
}
