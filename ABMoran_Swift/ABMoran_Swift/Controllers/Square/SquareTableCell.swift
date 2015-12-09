//
//  SquareTableCell.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/26/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation
import UIKit

class SquareTableCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var addreslab: UILabel!
    @IBOutlet weak var collcell: UICollectionView!
    
    var picture:PictureCollectionCell = PictureCollectionCell()
    var dataSource:Array<Picture> = []


    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! PictureCollectionCell
        cell.titlelab.text = self.dataSource[indexPath.row].title
        cell.picimage.sd_setImageWithURL(NSURL(string: self.dataSource[indexPath.row].pic_link!))
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let pic = self.dataSource[indexPath.row]
        Navigator.GotoDetail(pic)
    }
}
