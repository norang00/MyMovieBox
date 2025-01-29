//
//  DetailViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/29/25.
//

import UIKit

class DetailViewController: BaseViewController {

    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DetailViewController")
        print(#function, movie!)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
