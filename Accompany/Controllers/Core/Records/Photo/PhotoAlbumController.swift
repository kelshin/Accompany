//
//  PhotoAlbumController.swift
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

class PhotoAblumController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  let appName = "Accompany"
  let photoTitle = TitleLabel(title: "Photo Album", size: .medium)
  
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
  
  var uploadedImages = [Image]()
  var saveImgName = [String]()
  var imgURLArr = [URL]()
  
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
    collectionView.collectionViewLayout = createCollectionLayout()
    collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
  
    collectionView.dataSource = self
    collectionView.delegate = self


//    retrieveData(key: .keyForImage)
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "Photo Album ", style: .plain, target: nil, action: nil)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
  }
  
  func setupLabelLayout() {
    
    view.addSubview(photoTitle)
    photoTitle.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
  }
  
  func createCollectionLayout() -> UICollectionViewCompositionalLayout {
    let spacing: CGFloat = 4.0
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
    
    return UICollectionViewCompositionalLayout(section: section)
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
    var config = PHPickerConfiguration(photoLibrary: .shared())
    config.selectionLimit = 10
    config.filter = .images
    let vc = PHPickerViewController(configuration: config)
    vc.delegate = self
    self.present(vc, animated: true)
    
  }
  
  func accessPhoto() {
    let alert = UIAlertController(title: "Choose One Way", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
      self.openCamera()
    }))
    alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
      self.openPhotoGallery()
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  @objc func didTapAdd() {
    let alert = UIAlertController(title: "Add Photos?", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
      self.accessPhoto()

    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
  }
  
  
//
//  func save(image: UIImage) {
//    print("save!")
//
//    let imageData = image.pngData()! as NSData
//    UserDefaults.standard.set(imageData, forKey: .keyForImage)
//  }
  
  // CHECK THIS
  
  func saveImages(url: String) {
    for imageURL in saveImgName {
      let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      print(documentDirectory)
      let imgURL = documentDirectory.appendingPathComponent(imageURL).appendingPathExtension("plist")
      print(imgURL)
      if !FileManager.default.fileExists(atPath: imgURL.path) {
        do {
          try (UIImage(named:imageURL)!).pngData()?.write(to: imgURL)
          print("save")
        } catch {
          print("image not added")
        }
      }
      imgURLArr.append(imgURL)
    }
    
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let uiImage = info[.editedImage] as? UIImage {
      guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
//      print(fileUrl.lastPathComponent) // get file Name
      saveImgName.append(fileUrl.lastPathComponent)
      uploadedImages.append(Image(uiImage: uiImage))
      self.collectionView.reloadData()
      picker.dismiss(animated: true)
    }
    picker.dismiss(animated: true, completion: nil)
    
  }
}
  
extension PhotoAblumController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return uploadedImages.count
  }
  
  // CHECK THIS, view image
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else { fatalError() }
    cell.photoView.image = uploadedImages[indexPath.row].uiImage
    return cell
  }
  
}

extension PhotoAblumController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Go to detail", style: .default, handler: { (_) in
      let photoDetailVC = PhotoDetailedViewController()
      photoDetailVC.imageView.image = self.uploadedImages[indexPath.row].uiImage
      self.navigationController?.pushViewController(photoDetailVC, animated: true)
    }))
    
    alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (_) in
      let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
        self.uploadedImages.remove(at: indexPath.row)
        collectionView.reloadData()
      }))
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
      
      self.present(alert, animated: true, completion: nil)
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
    self.present(alert, animated: true, completion: nil)

  }

}

extension PhotoAblumController: PHPickerViewControllerDelegate {
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true, completion: nil)
    let group = DispatchGroup()
    
    results.forEach { result in
      group.enter()
      result.itemProvider.loadObject(ofClass: UIImage.self) { reading,error in
        defer {
          group.leave()
        }
        guard let image = reading as? UIImage, error == nil else {
          return
        }
//        self.saveImages(image: Image(uiImage: image))
        self.uploadedImages.append(Image(uiImage: image))
        
      }
    }
    group.notify(queue: .main) {
      self.collectionView.reloadData()
    }
    
  }
}

extension String {
  static let keyForImage = "data"
}

