//
//  ApiDataViewController.swift
//  Espasurdo
//
//  Created by José Henrique Fernandes Silva on 31/08/20.
//  Copyright © 2020 Morgana Beatriz. All rights reserved.
//

import UIKit
import WebKit

class ApiDataViewController: UIViewController {

    @IBOutlet weak var titelApod: UILabel!
    @IBOutlet weak var dateApod: UILabel!
    @IBOutlet weak var imageApod: UIImageView!
    @IBOutlet weak var explanationApod: UITextView!
    @IBOutlet weak var videoApod: WKWebView!
    
    var dataString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.load(dataString)
        
        self.videoApod.isHidden = true
        self.imageApod.isHidden = true
        
    }
    
    func load(_ data:String) {
        
        let stringURL = "https://api.nasa.gov/planetary/apod?date=\(data)&hd=true&api_key=dYH0lRMSlSXTg8fYucpDiHfUSIjghqrFKzMf6C3y"
        let url = URL(string: stringURL)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                let apodData: Apod = try decoder.decode(Apod.self, from: data!)
                
                // Baixar imagem e atualizar imagemView
                if apodData.mediaType == "image" {
                    self.updateImage(apodData.url)
                } else {
                    self.updateVideo(apodData.url)
                }
                self.updateTitleDate(apodData.title, apodData.date)
                
                
            } catch {
                print("Erro ao decodificar dados da API")
            }
        }
        task.resume()
        
    }
    
    func updateImage(_ url:String) {
        
        print("Entrou na função updateImage")
        DispatchQueue.global().async {
            print("Vai tentar baixar conteúdo da url")
            let data: Data
            do {
                // Baixar conteúdo da url
                print(url)
                data = try Data(contentsOf: URL(string: url)!)
            } catch {
                print("Erro ao tentar baixar imagem")
                return
            }
            
            DispatchQueue.main.async {
                
                self.videoApod.isHidden = true
                self.imageApod.isHidden = false
                
                self.imageApod.image = UIImage(data: data)!
                
                print("Atualizou imagem")
            }
        }
    }
    
    func updateVideo(_ url:String) {
        
        let request = URLRequest(url: URL(string: url)!)
        DispatchQueue.main.async {
            
            self.imageApod.isHidden = true
            self.videoApod.isHidden = false
            
            self.videoApod.load(request)
        }
        
        
    }
    
    func updateTitleDate(_ title:String, _ date:String) {
        
        DispatchQueue.main.async {
            self.titelApod.text = title
            self.dateApod.text = date
        }
        
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
