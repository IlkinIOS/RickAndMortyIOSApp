//
//  CharacterListViewViewModel.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 09.02.23.
//

import UIKit




protocol RMCharacterViewViewModelDelegate:AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPaths:[IndexPath])
    func didSelectCharacter(_ character:RMCharacter )
}


final class  RMCharacterListViewViewModel:NSObject {
    
    
    public weak var delegate:RMCharacterViewViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var characters:[RMCharacter] = [] {
        didSet {
           
            for character in characters  {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus:character.status,
                    characterImageUrl: URL(string: character.image))
                
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
                
                
                
            }
        }
    }
    
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharactersReponse.Info? = nil
     
    
    
    
    /// Fetch initial set of characters(20)
    public func fetchCharacters() {
        
        RMService.shared.execute(.listCharactersRequest, expecting:RMGetAllCharactersReponse.self) {  [weak self ] result in
            
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.apiInfo = info
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
            
        }
        
    }
    
    /// Paginate if additinal characters are needed
    public func fetchAdditinalCharacter(url:URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        
        guard let request = RMRequest(url: url ) else {
            isLoadingMoreCharacters = false
           
            return
        }
        RMService.shared.execute(request,expecting: RMGetAllCharactersReponse.self) { [weak self] result  in
            guard let strongSelf = self else {
                
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                  strongSelf.apiInfo = info
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indexPathsToAdd:[IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap {
                    
                    return IndexPath(row: $0, section: 0 )
                }
                 
                strongSelf.characters.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(with:indexPathsToAdd)
                    strongSelf.isLoadingMoreCharacters = false
                }
            case.failure(let failure):
                print(String(describing: failure ))
                strongSelf.isLoadingMoreCharacters = false
            }
        }
    }
    
    
    
    public var shouldShowLoadMoreIndicator:Bool {
        return  apiInfo?.next != nil
    }
    
    
    
}


extension RMCharacterListViewViewModel:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:RMCharacterCollectionViewCell.cellIndentifier, for: indexPath) as? RMCharacterCollectionViewCell  else {
            fatalError("Unsupported cell")
        }
        
        let viewModel = cellViewModels[indexPath.row]
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter , shouldShowLoadMoreIndicator
              else {
            fatalError("Unsupported")
        }
        
        guard  let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:RMFooterLoadingUICollectionReusableView.identifier, for: indexPath) as? RMFooterLoadingUICollectionReusableView     else {
            fatalError("Unsupported  ")
        }
        
        footer.startAnimating()
        return footer
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30)/2
        return CGSize(width:width, height:width * 1.5)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
          let character = characters[indexPath.row]
        
          delegate?.didSelectCharacter(character) 
        
    }
    
    
    
}


extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters ,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
              return
        }
       
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] T in
            let totalScrollViewFixedHeight = scrollView.bounds.size.height
               let totalContentHeight = scrollView.contentSize.height
               let offset = scrollView.contentOffset.y

            
               if offset + totalScrollViewFixedHeight >= totalContentHeight - 120 {
                   self?.fetchAdditinalCharacter(url: url)
                   
               }
               T.invalidate()
            
        }
        
    }
    
    
}
