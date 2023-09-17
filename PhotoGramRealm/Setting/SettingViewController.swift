//
//  SettingViewController.swift
//  PhotoGramRealm
//
//  Created by 박소진 on 2023/09/17.
//

import UIKit

class SettingViewController: BaseViewController {

    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())

    var dataSource: UICollectionViewDiffableDataSource<Setting.Section, Setting>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func configure() {
        view.addSubview(collectionView)

        title = "설정"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        configureDataSource()
    }

    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension SettingViewController {

    private func configureDataSource() {

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Setting>  { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.textProperties.color = .white
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = .black
            cell.backgroundConfiguration = backgroundConfig
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell

        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Setting.Section, Setting>()
        snapshot.appendSections([.settings, .persnal, .other])
        snapshot.appendItems(Setting.Section.settings.item, toSection: .settings)
        snapshot.appendItems(Setting.Section.persnal.item, toSection: .persnal)
        snapshot.appendItems(Setting.Section.other.item, toSection: .other)
        dataSource.apply(snapshot)
    }

    static private func layout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.backgroundColor = .black
        configuration.separatorConfiguration.color = .white

        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }

}

extension SettingViewController {
    
    struct Setting: Hashable {
        
        enum Section: CaseIterable {
            case settings
            case persnal
            case other
            
            var item: [Setting] {
                switch self {
                case .settings:
                    return [
                        Setting(title: "공지사항"),
                        Setting(title: "실험실"),
                        Setting(title: "버전 정보")
                    ]
                case .persnal:
                    return [
                        Setting(title: "개인/보안"),
                        Setting(title: "알림"),
                        Setting(title: "채팅"),
                        Setting(title: "멀티프로필")
                    ]
                case .other:
                    return [
                        Setting(title: "고객센터/도움말")
                    ]
                }
            }
        }
        
        let title: String
        private let id = UUID()
        
    }
    
}
