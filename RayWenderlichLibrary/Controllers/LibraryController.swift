


import UIKit

final class LibraryController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<TutorialCollection, Tutorial>!
    //Store data from the Plist
    private let tutorialCollections = DataSource.shared.tutorials
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    self.title = "Library"
      collectionView.delegate = self
      collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
      collectionView.collectionViewLayout = configureCollectionViewLayout()
      configureDataSource()
      configureSnapshot()
  }
}

//MARK: Collection View

extension LibraryController{
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout{
       //Depending on which section your in you can customize the cell size
        let sectionProvider = {(sectionIndex: Int, layoutEnvronment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //takes up the entire size of the group that contains it
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            
            //header or footer its considered a boundry supplementary item
            let headerSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
    //Return an instance that uses our provider
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}

//MARK: - Diffable Data Source
extension LibraryController{
    typealias TutorialDataSource = UICollectionViewDiffableDataSource<TutorialCollection, Tutorial>
    
    func configureDataSource(){
        //init with collection view
        //configure the cell
        dataSource = TutorialDataSource(collectionView: collectionView){(collectionView: UICollectionView, indexPath: IndexPath, tutotrial: Tutorial) ->
            UICollectionViewCell? in
            
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCell.reuseIdentifier, for: indexPath) as? TutorialCell else{
                return nil
            }
            cell.titleLabel.text = tutotrial.title
            cell.thumbnailImageView.image = tutotrial.image
            cell.thumbnailImageView.backgroundColor = tutotrial.imageBackgroundColor

            return cell
        }
        
        //diffable data sources take a supplementary view provider that takes a closure
        dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind:String, indexPath: IndexPath) -> UICollectionReusableView? in
            //if the sup header is a section header deque a header for use
            
            if let self  = self, let titleSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier, for: indexPath) as? TitleSupplementaryView {
             
                let tutorialCollection = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                titleSupplementaryView.textLabel.text = tutorialCollection.title
                return titleSupplementaryView
            }
            else{
                return nil
            }
        }
    }
    
    //configure snapshot
    func configureSnapshot(){
        var currentSnapshot = NSDiffableDataSourceSnapshot<TutorialCollection, Tutorial>()
        //itterate over the collection and add it to the snapshot
        tutorialCollections.forEach { collection in
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.tutorials)
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}

//MARK: - UIcollectionViewDelegate
extension LibraryController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let tutorial = dataSource.itemIdentifier(for: indexPath),
           let tutorialDetailController = storyboard?.instantiateViewController(identifier: TutorialDetailViewController.identifier, creator: { coder in
               return TutorialDetailViewController(coder: coder, tutorial: tutorial)
           }){
            //get destination view controller
            //instance of the controller using the initialiser
            
            show(tutorialDetailController, sender: nil)
        }
    }
}
