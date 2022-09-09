


import UIKit

final class LibraryController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    self.title = "Library"
      collectionView.collectionViewLayout = configureCollectionViewLayout()
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
            
            return section
        }
    //Return an instance that uses our provider
    }
}
