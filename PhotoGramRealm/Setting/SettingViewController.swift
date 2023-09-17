//
//  SettingViewController.swift
//  PhotoGramRealm
//
//  Created by 박소진 on 2023/09/17.
//

import UIKit

class SettingViewController: BaseViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    var list = ["방해 금지 모드", "수면", "업무", "개인 시간", "모든 기기에서 공유"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        view.addSubview(collectionView)
        
        title = "집중 모드"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
        
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension SettingViewController {
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>  { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.textProperties.color = .white
            content.secondaryText = "secondText"
            content.secondaryTextProperties.color = .white
            content.imageProperties.tintColor = .systemYellow
            content.image = UIImage(systemName: "heart.fill")
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
            backgroundConfig.cornerRadius = 15
            cell.backgroundConfiguration = backgroundConfig
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
            
        })
    }
    
    static private func layout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
//        configuration.showsSeparators = false
        configuration.backgroundColor = .black
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
}
