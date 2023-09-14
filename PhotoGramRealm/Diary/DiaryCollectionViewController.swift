//
//  DiaryCollectionViewController.swift
//  PhotoGramRealm
//
//  Created by 박소진 on 2023/09/14.
//

import UIKit

class DiaryCollectionViewController: BaseViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func layout() {
        
    }
}

extension DiaryCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
