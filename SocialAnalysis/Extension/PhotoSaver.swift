//
//  PhotoSaver.swift
//  YPImgePicker
//
//  Created by Sacha Durand Saint Omer on 10/11/16.
//  Copyright © 2016 Yummypets. All rights reserved.
//

import Foundation
import Photos

public class PhotoSaver {
    
    public static var albumName = "ChristmasRingtones"
    public static var videoAlbumName = "ChristmasRingtones"
    
    class func trySaveImage(_ image: UIImage) {
     
        if let album = album(named: albumName) {
            saveImage(image, toAlbum: album)
        } else {
            createAlbum(withName: albumName) {
                if let album = album(named: albumName) {
                    saveImage(image, toAlbum: album)
                }
            }
        }
    }
    
    class func trySaveVideo(_ videoURL: URL){
        if let album = album(named: videoAlbumName) {
            saveVideo(videoURL, toAlbum: album)
        } else {
            createAlbum(withName: videoAlbumName) {
                if let album = album(named: videoAlbumName) {
                    saveVideo(videoURL, toAlbum: album)
                }
            }
        }
    }
    
    
//   class func downloadAndSaveImage(_ url: String, completion:@escaping (_ isSuccess:Bool) -> Void)  {
//        ez.requestImage(url) { (image) in
//            if image == nil{
//                completion(false)
//            }else{
//                PhotoSaver.trySaveImage(image!)
//                completion(true)
//            }
//        }
//    }
    
   class func createNewTempFilePath(_ path: String) -> URL {
        //creating a path for file and checking if it already exist if exist then delete it
        let outputPath: String = "\(NSTemporaryDirectory())\(path)"
        var success: Bool
        let fileManager = FileManager.default
        success = fileManager.fileExists(atPath: outputPath)
        if success {
            success = ((try? fileManager.removeItem(atPath: outputPath)) != nil)
        }
        return URL.init(fileURLWithPath: outputPath)
    }
    
    class func downloadAndSaveVideo(_ url: URL,name:String, completion:@escaping (_ isSuccess:Bool) -> Void)  {
        URLSession.shared.dataTask(
            with: URLRequest(url: url),
            completionHandler: { data, response, err in
                if err != nil {
                    completion(false)
                } else {
                    DispatchQueue.main.async {
                        let filePath = PhotoSaver.createNewTempFilePath(name)
                        try! data?.write(to: filePath)
                        trySaveVideo(filePath)
                        completion(true)
                    }
                }
        }).resume()
    }
    
    class func trySaveImageToAsset(_ image: UIImage) {
        saveImage(image)
    }
}

func album(named: String) -> PHAssetCollection? {
    let fetchOptions = PHFetchOptions()
    fetchOptions.predicate = NSPredicate(format: "title = %@", named)
    let collection = PHAssetCollection.fetchAssetCollections(with: .album,
                                                             subtype: .any,
                                                             options: fetchOptions)
    return collection.firstObject
}

func saveImage(_ image: UIImage, toAlbum album: PHAssetCollection) {
    PHPhotoLibrary.shared().performChanges({
        let changeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
        let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
        let enumeration: NSArray = [changeRequest.placeholderForCreatedAsset!]
        albumChangeRequest?.addAssets(enumeration)
    })
}
func saveImage(_ image: UIImage){
    PHPhotoLibrary.shared().performChanges({
        PHAssetChangeRequest.creationRequestForAsset(from: image)
    })
}

func createAlbum(withName name: String, completion:@escaping () -> Void) {
    PHPhotoLibrary.shared().performChanges({
        PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
    }) { success, _ in
        if success {
            completion()
        }
    }
}
func saveVideoToAsset(_ videoURL: URL, completion:@escaping (_ isSuccess:Bool) -> Void){
    PHPhotoLibrary.shared().performChanges({
        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
    }) { success, _ in
        if success {
          completion(true)
        }else{
            completion(false)
        }
    }
}
func saveVideo(_ videoURL: URL, toAlbum album: PHAssetCollection) {
    PHPhotoLibrary.shared().performChanges({
        let changeRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
        let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
        let enumeration: NSArray = [changeRequest!.placeholderForCreatedAsset!]
        albumChangeRequest?.addAssets(enumeration)
    })
}




