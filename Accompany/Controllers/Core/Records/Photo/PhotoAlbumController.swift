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

    loadFileNames()
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
    
    print(uploadedImages)
    print(saveImgName)
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
      imagePicker.allowsEditing = false
      
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
    let alert = UIAlertController(title: "Accompany Would Like to Access your Photos.", message: "Choose one way to upload photos", preferredStyle: .alert)
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
    self.accessPhoto()
  }
  
  func loadFileNames() {
    guard let saveImgName = listFilesFromDocumentsFolder() else { return }
    print(saveImgName)
    _ = saveImgName.map{ uploadedImages.append(Image(uiImage: loadImageFromDiskWith(fileName: $0) ?? UIImage(named: appName)!, uuid: $0))}
    self.collectionView.reloadData()
  }
  
  func listFilesFromDocumentsFolder() -> [String]?
  {
    let fileMngr = FileManager.default;
    let docs = fileMngr.urls(for: .documentDirectory, in: .userDomainMask).first!.path
    
    return try? fileMngr.contentsOfDirectory(atPath:docs)
  }
  
  func loadImageFromDiskWith(fileName: String) -> UIImage? {
    let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

      let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
      let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

      if let dirPath = paths.first {
          let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
          let image = UIImage(contentsOfFile: imageUrl.path)
          return image
      }
      return nil
  }
  
  //SAVE IMAGE TO ARRAY
  
  func saveImages(image: UIImage, filename: String) {
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//    let fileName = UUID().description
    var imgURL = documentDirectory.appendingPathComponent(filename)
    guard let data = image.jpegData(compressionQuality: 1) else { return }
      if FileManager.default.fileExists(atPath: imgURL.path) {
        do {
          imgURL = documentDirectory.appendingPathComponent(filename)
          try FileManager.default.removeItem(atPath: imgURL.path)
          print("Removed old image")
        } catch let removeError {
          print("couldn't remove file at path", removeError)
        }
      }
      do {
        try data.write(to: imgURL)
        saveImgName.append(filename)
      } catch {
        print("image not added")
      }
      imgURLArr.append(imgURL)
  }
  
  func deleteFile(filename : String) {
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var imgURL = documentDirectory.appendingPathComponent(filename)
      if FileManager.default.fileExists(atPath: imgURL.path) {
        do {
          imgURL = documentDirectory.appendingPathComponent(filename)
          try FileManager.default.removeItem(atPath: imgURL.path)
          print("Removed old image")
        } catch let removeError {
          print("couldn't remove file at path", removeError)
        }
      }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let uiImage = info[.originalImage] as? UIImage {
      uploadedImages.append(Image(uiImage: uiImage))
      self.saveImages(image: uiImage, filename: uploadedImages.last!.uuid)
      self.collectionView.reloadData()
      picker.dismiss(animated: true)
    }
    picker.dismiss(animated: true, completion: nil)
    self.collectionView.reloadData()
  }
}
  
extension PhotoAblumController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return uploadedImages.count
  }
  
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
        self.deleteFile(filename: self.uploadedImages[indexPath.row].uuid.description)
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
        print(result)
        self.uploadedImages.append(Image(uiImage: image))
        self.saveImages(image: image, filename: self.uploadedImages.last!.uuid)
        
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
