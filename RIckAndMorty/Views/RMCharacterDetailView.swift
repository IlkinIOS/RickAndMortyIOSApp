//
//  RMCharacterDetailView.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 19.02.23.
//

import UIKit

 final class RMCharacterDetailView: UIView {

     
       public var collectionView:UICollectionView?
     
       private let viewModel:RMCharacterDetailViewViewModel
     
     private let spinner: UIActivityIndicatorView = {
         let spinner = UIActivityIndicatorView(style: .large)
         spinner.hidesWhenStopped = true
         spinner.translatesAutoresizingMaskIntoConstraints = false
         
         return spinner
     }()
     
     
     
     init(frame: CGRect,viewModel: RMCharacterDetailViewViewModel) {
         self.viewModel = viewModel
         super.init(frame: frame)
         translatesAutoresizingMaskIntoConstraints = false
         backgroundColor = .systemBackground
         let collectionView = createCollectionView()
         self.collectionView = collectionView
          addSubviews(collectionView,spinner)
         
         addConstraints()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     
     
     
     
     private func addConstraints() {
         
         guard let collectionView = collectionView else {
           return
         }
         
         NSLayoutConstraint.activate([
        
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            // Collection view's constraints
            collectionView.topAnchor.constraint(equalTo:topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo:rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
         
         ])
         
         
     }
     
     
     
     private func createCollectionView() -> UICollectionView {
         let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
             return  self.createSection(for:sectionIndex)
         }
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout:layout)

         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         return collectionView


     }

     private func createSection(for sectionIndex:Int) -> NSCollectionLayoutSection {
         
         let sectionTypes = viewModel.sections
         
         switch sectionTypes[sectionIndex] {
         case .photo:
             return createPhotoSectionLayout()
         case .information:
             return createInfoSectionLayout()
         case .episodes:
             return createEpisodeSectionLayout()
         }
         
     }
     
     
     private func createPhotoSectionLayout() -> NSCollectionLayoutSection {
         
         let itemSize =  NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
         let item = NSCollectionLayoutItem(layoutSize:itemSize)
         item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
         
         let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.absolute(150))
         let group = NSCollectionLayoutGroup.vertical(layoutSize:groupSize , subitems: [item])
         group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
         
         let section = NSCollectionLayoutSection(group: group)
         
         return section
         
     }
     
     
     
     private func createInfoSectionLayout() -> NSCollectionLayoutSection {
         
         let itemSize =  NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
         let item = NSCollectionLayoutItem(layoutSize:itemSize)
         item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
         
         let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.absolute(100))
         let group = NSCollectionLayoutGroup.vertical(layoutSize:groupSize , subitems: [item])
         group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
         
         let section = NSCollectionLayoutSection(group: group)
         
         return section
         
     }
     
     
     
     
     private func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
         
         let itemSize =  NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
         let item = NSCollectionLayoutItem(layoutSize:itemSize)
         item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
         
         let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.absolute(50))
         let group = NSCollectionLayoutGroup.vertical(layoutSize:groupSize , subitems: [item])
         group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
         
         let section = NSCollectionLayoutSection(group: group)
         
         return section
         
     }
     
     
}




