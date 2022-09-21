//
//  BabySonogramController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-14.
//

import Foundation
import Photos
import PhotosUI
import UIKit
import SnapKit
import Gallery

class BabySonogramController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
  
  // MARK: Section Definitions
  enum Section: Hashable {
    case slidePhoto
    case uploadPhoto
  }
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Image>!
  
  let appName = "Accompany"
  let photoTitle = TitleLabel(title: "Photo Album", size: .medium)
  
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
  
  // MARK: Data
  
  var slideImages: [Image] = {
    var slideArr = [Image]()
    for i in 1...10 {
      slideArr.append(Image(id: i, uiImage: UIImage(named: "logo-app")!))
    }
    
    return slideArr
  }()
  
  var uploadedImages: [Image] = {
    var uploadArr = [Image]()
    
    for i in 11...60 {
      uploadArr.append(Image(id: i, uiImage: UIImage(named: "logo-app")!))
    }
    
    return uploadArr
  }()
  
  var sections = [Section]()
  
  var snapshot: NSDiffableDataSourceSnapshot<Section, Image> {
      var snapshot = NSDiffableDataSourceSnapshot<Section, Image>()
    snapshot.appendSections([.slidePhoto])
    snapshot.appendItems(slideImages, toSection: .slidePhoto)

      snapshot.appendSections([.uploadPhoto])
      snapshot.appendItems(uploadedImages, toSection: .uploadPhoto)

      sections = snapshot.sectionIdentifiers

      dataSource.apply(snapshot)
      return snapshot
    }
  
  var selectedIndexPath: IndexPath?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    setupLabelLayout()
    
    // collectionView
    collectionView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
      make.top.equalTo(photoTitle.snp.bottom)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    collectionView.collectionViewLayout = createLayout()
    collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    
    configureDataSource()
    configCollectionView()
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "Photo Album ", style: .plain, target: nil, action: nil)
  }
  
  func openCamera() {
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .camera
      imagePicker.allowsEditing = true
      
      self.present(imagePicker, animated: true, completion: nil)
    }
    
  }
  
  func openPhotoGallery() {
    
    if UIImagePickerController.isSourceTypeAvailable((.photoLibrary)) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .photoLibrary
      imagePicker.allowsEditing = true
      
      self.present(imagePicker, animated: true, completion: nil)
    }
    
  }
  
  func gotoDetail() {
    
    let photoDetailVC = PhotoDetailedViewController()
    if selectedIndexPath!.section == 0 {
      photoDetailVC.imageView.image = slideImages[selectedIndexPath!.row].uiImage
    } else if selectedIndexPath!.section == 1 {
      photoDetailVC.imageView.image = uploadedImages[selectedIndexPath!.row].uiImage
    }
    
    navigationController?.pushViewController(photoDetailVC, animated: true)
    
  }
  
  func configureDataSource() {
    
    // MARK: Data Source Initialization
    dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
      let section = self.sections[indexPath.section]
      switch section {
      case .slidePhoto:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.photoView.image = item.uiImage
        
        return cell
        
      case .uploadPhoto:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.photoView.image = item.uiImage
        return cell
        
      }
    })
    
    // MARK: Snapshot Definition
    dataSource.apply(snapshot)
  
  }
  
  
  func configCollectionView() {
    
    collectionView.delegate = self
    
  }
  
  func setupLabelLayout() {
    
    view.addSubview(photoTitle)
    photoTitle.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
  }
  
  func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout
    { (sectionIndex, layoutEnvironment) ->
      NSCollectionLayoutSection? in
      let section = self.sections[sectionIndex]
      let spacing: CGFloat = 4.0
      switch section {
      case .slidePhoto:
        // MARK: SlidePhoto Section Layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
        
      case .uploadPhoto:
        // MARK: UploadPhoto Section Layout
        // 'Triplet' - three 1/3 width items stacked horizontally
        let tripleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3)))
        tripleItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let tripleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3)), subitems: [tripleItem, tripleItem, tripleItem])
        tripleGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        // 'Double' - two 1/2 width items stacked horizontally
        let doubleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalWidth(1/2)))
        doubleItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let doubleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/2)), subitems: [doubleItem, doubleItem])
        doubleGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(5/3)), subitems: [tripleGroup, doubleGroup])
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.orthogonalScrollingBehavior = .none
        
        return section
        
      }
    }
    return layout
    
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    print(selectedIndexPath!.row)
    print(selectedIndexPath!.section)
    
    // update snapshot
    let uiImage = info[.editedImage] as! UIImage
    // TODO: Upload Image to Database
    
    if (selectedIndexPath!.section == 0 ) && (selectedIndexPath!.row < slideImages.count) {
      slideImages[selectedIndexPath!.row].uiImage = uiImage
    } else if (selectedIndexPath!.section == 1) && (selectedIndexPath!.row < uploadedImages.count) {
      uploadedImages[selectedIndexPath!.row].uiImage = uiImage
    }
    
    // update dataSource
    dataSource.apply(snapshot, animatingDifferences: true)
    self.dismiss(animated: true, completion: nil)
    
  }
  
}

extension BabySonogramController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
      let alert = UIAlertController(title: "\(appName) APP Would Like to Access your Photos.", message: "Choose one way to upload photos", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
        self.openCamera()
      }))
      alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
        self.openPhotoGallery()
      }))
      alert.addAction(UIAlertAction(title: "Go to Detail", style: .default, handler: { (_) in
        if (self.slideImages[self.selectedIndexPath!.row].uiImage == UIImage(named: "logo-app")!) && (self.uploadedImages[self.selectedIndexPath!.row].uiImage == UIImage(named: "logo-app")!)  {
          let alert = UIAlertController(title: "Make sure you upload the photo first", message: nil, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default))
          self.present(alert, animated: true, completion: nil)
        } else {
          self.gotoDetail()
        }
      }))

      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

      self.present(alert, animated: true, completion: nil)

      selectedIndexPath = indexPath
    
  }

}

