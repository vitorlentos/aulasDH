//
//  CarListController.swift
//  MVC-OK
//
//  Created by Vitor Lentos on 27/07/21.
//

import Foundation

protocol CarListControllerProtocol: AnyObject {
    
    func success();
    func failed();
    
    
}


class CarListController {
    
    private var arrayCarros:[Carro] = [];
    
    //MARK:- Protocolo
    var delegate: CarListControllerProtocol?
    
    func setUpDelegate(delegate: CarListControllerProtocol?){
        self.delegate = delegate.self;
    }
    
//    init(delegate: CarListControllerProtocol?) {
//        self.delegate = delegate;
//    }
    
    func loadCarrosComProtocolo(){
        if let path = Bundle.main.path(forResource: "carros", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe);
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves);
                if let _jsonResult = jsonResult as? Dictionary<String, AnyObject>, let carros = _jsonResult["carros"] as? [[String:Any]] {
                    for value in carros {
                        self.arrayCarros.append(Carro.init(dicionario: value));
                    }
                    self.delegate?.success();
                }
            } catch {
                self.delegate?.failed();
            }
        }
    }
    //MARK:- Closure
    
    //Variável apenas de leitura
    var count: Int {
        return self.arrayCarros.count;
    }
    
    func loadCurrentCarro(indexPath:IndexPath) -> Carro{
        return self.arrayCarros[indexPath.row];
    }
    
    func carregaCarros(completionHandler: (_ result: Bool, _ error: Error?) -> Void){
        if let path = Bundle.main.path(forResource: "carros", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe);
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves);
                if let _jsonResult = jsonResult as? Dictionary<String, AnyObject>, let carros = _jsonResult["carros"] as? [[String:Any]] {
                    for value in carros {
                        self.arrayCarros.append(Carro.init(dicionario: value));
                    }
                    completionHandler(true, nil);
                }
            } catch {
                completionHandler(false, error);
            }
        }
    }
}
