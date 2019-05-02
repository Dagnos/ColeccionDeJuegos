//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by Fernando Huarcaya Torres on 4/25/19.
//  Copyright © 2019 Fernando Huarcaya Torres. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    var juego:Juego? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if juego != nil {
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
        }
        
        //para el combo vox
        lista.delegate = self
        lista.dataSource = self
        
        //para ocultar la tabla
        lista.isHidden = true
    }
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func camaraTapped(_ sender: Any) {
    }
    @IBAction func agregarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let juego = Juego(context: context)
        juego.titulo = tituloTextField.text
        juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true) 
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        JuegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    let categorias = ["accion","supervivencia","psicologico","terror"]
    
    @IBAction func btnComboBox(_ sender: Any) {
        if lista.isHidden{
            animate(toogle: true)
        }else{
            animate(toogle: false)
        }
    }
    func animate(toogle: Bool){
        if toogle{
            UIView.animate(withDuration: 0.3){
                self.lista.isHidden = false
            }
        }else{
            UIView.animate(withDuration: 0.3){
                self.lista.isHidden = true
            }
        }
    }
    @IBOutlet weak var lista: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categorias[indexPath.row]
        return cell
    }

}
