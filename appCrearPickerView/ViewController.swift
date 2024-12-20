//
//  ViewController.swift
//  appCrearPickerView
//
//  Created by Guest User on 12/11/24.
//

import UIKit

class ViewController: UIViewController {

    // Conexiones de los IBOutlets
    @IBOutlet weak var texto1: UITextField!
    @IBOutlet weak var imagen1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!

    // Datos del país (nombre, bandera, y una pequeña descripción)
    let paises = [
        "México": ("🇲🇽", "Una nación rica en historia y cultura.", "mexico"),
        "Bélgica": ("🇧🇪", "Famosa por su chocolate, cerveza y arquitectura medieval.", "belgica"),
        "Chile": ("🇨🇱", "Una larga franja de tierra que se extiende a lo largo de la costa del Pacífico.", "chile"),
        "USA": ("🇺🇸", "Una nación conocida por su diversidad y poderío global.", "usa"),
        "España": ("🇪🇸", "Famosa por su comida, su arquitectura, y su influencia cultural.", "espana"),
        "Palestina": ("🇵🇸", "Conocida por su historia y su lucha por la paz.", "palestina"),
        "Ucrania": ("🇺🇦", "Un país con una rica historia y paisajes hermosos.", "ukrania"),
        "China": ("🇨🇳", "La nación más poblada del mundo y con una rica tradición cultural.", "china"),
        "Taiwan": ("🇹🇼", "Una isla conocida por su tecnología y hermosos paisajes.", "taiwan"),
        "Japón": ("🇯🇵", "Famosa por su tecnología avanzada y su rica cultura milenaria.", "japon"),
        "Colombia": ("🇨🇴", "Un país con hermosos paisajes naturales y una cultura vibrante.", "colombia"),
        "Brasil": ("🇧🇷", "Conocido por su samba, fútbol y la Amazonía.", "brasil")
    ]

    var banderaSeleccionada: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        crearPickerView()
        crearToolBar()
    }

    func crearPickerView() {
        let banderasPicker = UIPickerView()
        banderasPicker.delegate = self
        texto1.inputView = banderasPicker
    }

    func crearToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.barTintColor = .gray
        toolBar.tintColor = .black
        let botonOcultar = UIBarButtonItem(title: "⬇️", style: .plain, target: self, action: #selector(ViewController.dismissKeyboard))
        toolBar.setItems([botonOcultar], animated: true)
        toolBar.isUserInteractionEnabled = true
        let botonAdios = UIBarButtonItem(title: "👋🏼", style: .plain, target: self, action: #selector(ViewController.adios))
        toolBar.setItems([botonAdios], animated: false)
        let espacio = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.toolbarItems = [botonOcultar, espacio, botonAdios]
        toolBar.setItems(toolbarItems, animated: false)
        texto1.inputAccessoryView = toolBar
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func adios() {
        UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return paises.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(paises.keys)[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let paisSeleccionado = Array(paises.keys)[row]
        banderaSeleccionada = paisSeleccionado

        // Actualizar el texto1 (campo de texto)
        texto1.text = paisSeleccionado
        texto1.backgroundColor = UIColor.blue

        // Mostrar la bandera en imagen1
        let bandera = paises[paisSeleccionado]?.0
        imagen1.image = UIImage(named: bandera ?? "")
        imagen1.image = UIImage(named: paises[paisSeleccionado]?.2 ?? "")


        // Mostrar los textos relacionados con el país en los labels
        label1.text = paises[paisSeleccionado]?.1
        label2.text = "Más información sobre \(paisSeleccionado)"
        
        // Cambiar el color de fondo de la vista
        self.view.backgroundColor = UIColor.green
        
        
        print("Intentando cargar imagen: \(paises[paisSeleccionado]?.2 ?? "")")
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        label.textColor = UIColor.orange
        label.textAlignment = .center
        label.font = UIFont(name: "Futura", size: 24)
        label.text = Array(paises.keys)[row]
        return label
    }
}
