//
//  FocusViewController.swift
//  PhotoGramRealm
//
//  Created by 박소진 on 2023/09/17.
//

import UIKit

class FocusViewController: BaseViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    var dataSource: UICollectionViewDiffableDataSource<Focus.Section, Focus>!
    
    var color: [UIColor] = [.purple, .orange, .systemGreen, .systemBlue]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        view.addSubview(collectionView)
        
        title = "집중 모드"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        configureDataSource()
        
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension FocusViewController {
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Focus> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.textProperties.color = .white
            content.secondaryText = itemIdentifier.secondText
            content.secondaryTextProperties.color = .white
            content.imageProperties.tintColor = self.color[indexPath.item]
            content.image = UIImage(systemName: itemIdentifier.image)
            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator(options: .init(tintColor: .darkGray))]
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
            backgroundConfig.cornerRadius = 10
            cell.backgroundConfiguration = backgroundConfig
            
        }
        
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
            
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Focus.Section, Focus>()
        snapshot.appendSections([.setting, .share])
        snapshot.appendItems(Focus.Section.setting.item, toSection: .setting)
        snapshot.appendItems(Focus.Section.share.item, toSection: .share)
        dataSource.apply(snapshot)
        
    }
    
    static private func layout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .black
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}

extension FocusViewController {
    
    struct Focus: Hashable {
        
        enum Section: CaseIterable {
            case setting
            case share
            
            var item: [Focus] {
                switch self {
                case .setting:
                    return [
                        Focus(title: "방해 금지 모드", image: "star", secondText: "켬"),
                        Focus(title: "수면", image: "heart", secondText: ""),
                        Focus(title: "업무", image: "person", secondText: ""),
                        Focus(title: "개인 시간", image: "pencil", secondText: "설정")
                    ]
                case .share:
                    return [Focus(title: "모든 기기에서 공유", image: "", secondText: "")]
                }
            }
        }
        
        let title: String
        let image: String
        let secondText: String
        
        private let id = UUID()
    }
    
}
