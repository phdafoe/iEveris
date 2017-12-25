//
//  ParserGenerico.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class ParserGenerico: NSObject {
    
    /*http://app.clubsinergias.es/api_comercios.php?idlocalidad=11&tipo=oferta&p=promociones
     CONSTANTES.LLAMADAS.BASE_URL + CONSTANTES.LLAMADAS.BASEIDLOCALIDAD + idLocalidad + CONSTANTES.LLAMADAS.BASEIDTIPO + idTipo + CONSTANTES.LLAMADAS.BASEIDP + idParametro*/
    //http://andresocampo.com/pruebas/iSaldos/concursos.json
    
    var jsonDataGenerico : JSON?
    
    func getDatosGenerico(_ idLocalidad : String, idTipo : String, idParametro : String) -> Promise<JSON>{
        let request = URLRequest(url: URL(string:  CONSTANTES.LLAMADAS.BASE_URL + CONSTANTES.LLAMADAS.BASEIDLOCALIDAD + idLocalidad + CONSTANTES.LLAMADAS.BASEIDTIPO + idTipo + CONSTANTES.LLAMADAS.BASEIDP + idParametro)!)
        print(request)
        
        return Alamofire.request(request).responseJSON().then{(data) -> JSON in
            self.jsonDataPromociones = JSON(data)
            return self.jsonDataPromociones!
        }
    }
    
    func getParserGenerico() -> [GenericModelData]{
        var arrayPromocionesModel = [GenericModelData]()
        for c_Promocion in (jsonDataPromociones?["promociones"])!{
            
            let asociadoModel = AsociadoModel(pId: dimeString(c_Promocion.1["asociado"], nombre: "id"),
                                                pNombre: dimeString(c_Promocion.1["asociado"], nombre: "nombre"),
                                                pDescripcion: dimeString(c_Promocion.1["asociado"], nombre: "descripcion"),
                                                pCondicionesEspeciales: dimeString(c_Promocion.1["asociado"], nombre: "condicionesEspeciales"),
                                                pDireccion: dimeString(c_Promocion.1["asociado"], nombre: "direccion"),
                                                pIdActividad: dimeString(c_Promocion.1["asociado"], nombre: "idActividad"),
                                                pIdLocalidad: dimeString(c_Promocion.1["asociado"], nombre: "idLocalidad"),
                                                pImagen: dimeString(c_Promocion.1["asociado"], nombre: "imagen"),
                                                pTelefonoFijo: dimeString(c_Promocion.1["asociado"], nombre: "telefonoFijo"),
                                                pTelefonoMovil: dimeString(c_Promocion.1["asociado"], nombre: "telefonoMovil"),
                                                pMail: dimeString(c_Promocion.1["asociado"], nombre: "mail"),
                                                pWeb: dimeString(c_Promocion.1["asociado"], nombre: "web"))
            
            
            let promocionesModel = GenericModelData(pId: dimeString(c_Promocion.1, nombre: "id"),
                                                  pTipoPromocion: dimeString(c_Promocion.1, nombre: "tipoPromocion"),
                                                  pNombre: dimeString(c_Promocion.1, nombre: "nombre"),
                                                  pImporte: dimeString(c_Promocion.1, nombre: "importe"),
                                                  pImagen: dimeString(c_Promocion.1, nombre: "imagen"),
                                                  pFechaFin: dimeString(c_Promocion.1, nombre: "fechaFin"),
                                                  pMasInformacion: dimeString(c_Promocion.1, nombre: "masInformacion"),
                                                  pAsociado: asociadoModel)
            
            arrayPromocionesModel.append(promocionesModel)
        }
        return arrayPromocionesModel
    }
    
    
    

}
