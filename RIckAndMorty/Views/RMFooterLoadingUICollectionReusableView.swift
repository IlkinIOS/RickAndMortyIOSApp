//
//  RMFooterLoadingUICollectionReusableView.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 21.02.23.
//

import UIKit

 final class RMFooterLoadingUICollectionReusableView: UICollectionReusableView {

     static let identifier = "RMFooterLoadingUICollectionReusableView"
     
     
     private var spinner:UIActivityIndicatorView = {
         let spinner = UIActivityIndicatorView()
         spinner.hidesWhenStopped = true
         
         spinner.translatesAutoresizingMaskIntoConstraints = false
         spinner.style = .large
         
         return spinner
         
         
     } ()
     
     
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         backgroundColor = .systemBackground
         addSubview(spinner)
         addConstraints()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     private func addConstraints() {
         NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
         
         ])
     }
     
     
     public func startAnimating() {
         spinner.startAnimating()
     }
     
     
     
     
}
