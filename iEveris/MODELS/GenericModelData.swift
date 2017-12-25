//
//  GenericModelData.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class GenericModelData: NSObject {
    
    var id : String?
    var tipoPromocion : String?
    var nombre : String?
    var importe : String?
    var imagen : String?
    var fechaFin : String?
    var masInformacion : String?
    var asociado : AsociadoModel?
    
    init(pId : String, pTipoPromocion : String, pNombre : String, pImporte : String, pImagen : String, pFechaFin : String, pMasInformacion : String, pAsociado : AsociadoModel) {
        
        self.id = pId
        self.tipoPromocion = pTipoPromocion
        self.nombre = pNombre
        self.importe = pImporte
        self.imagen = pImagen
        self.fechaFin = pFechaFin
        self.masInformacion = pMasInformacion
        self.asociado = pAsociado
        super.init()
    }
    
}

class AsociadoModel: NSObject {
    var id : String?
    var nombre : String?
    var descripcion : String?
    var condicionesEspeciales : String?
    var direccion : String?
    var idActividad : String?
    var idLocalidad : String?
    var imagen : String?
    var telefonoFijo : String?
    var telefonoMovil : String?
    var mail : String?
    var web : String?
    
    
    init(pId : String, pNombre : String, pDescripcion : String, pCondicionesEspeciales : String, pDireccion : String, pIdActividad : String, pIdLocalidad : String, pImagen : String, pTelefonoFijo : String, pTelefonoMovil : String, pMail : String, pWeb : String) {
        
        self.id = pId
        self.nombre = pNombre
        self.descripcion = pDescripcion
        self.condicionesEspeciales = pCondicionesEspeciales
        self.direccion = pDireccion
        self.idActividad = pIdActividad
        self.idLocalidad = pIdLocalidad
        self.imagen = pImagen
        self.telefonoFijo = pTelefonoFijo
        self.telefonoMovil = pTelefonoMovil
        self.mail = pMail
        self.web = pWeb
        super.init()
    }
}
