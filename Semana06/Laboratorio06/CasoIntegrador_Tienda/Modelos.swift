//
//  Modelos.swift
//  CasoIntegrador_Tienda
//
//  Created by NAOMI SANCHEZ on 7/10/26.
//

// Desarrollado por: NAOMI SANCHEZ
import UIKit

// MARK: - Modelo de Producto
class Producto {
    let nombre: String
    let precio: Double
    var stock: Int
    
    init(nombre: String, precio: Double, stock: Int) {
        self.nombre = nombre
        self.precio = precio
        self.stock = stock
    }
}

// MARK: - Modelo de Item en Carrito
class ItemCarrito {
    let producto: Producto
    var cantidad: Int
    
    init(producto: Producto, cantidad: Int) {
        self.producto = producto
        self.cantidad = cantidad
    }
    
    func subtotal() -> Double {
        return producto.precio * Double(cantidad)
    }
}

// MARK: - Modelo de Cliente
class ClienteModel {
    var apellido: String = ""
    var nombre: String = ""
    var dni: String = ""
}

// MARK: - Modelo de Carrito
class CarritoModel {
    var items: [ItemCarrito] = []
    
    // TODO A1: Agregar producto validando el stock
    func agregar(producto: Producto, cantidad: Int) -> Bool {
        let existente = items.first(where: { $0.producto.nombre == producto.nombre })
        let cantidadActualEnCarrito = existente?.cantidad ?? 0
        
        // Validación de stock acumulado
        if (cantidadActualEnCarrito + cantidad) > producto.stock {
            return false
        }
        
        if let item = existente {
            item.cantidad += cantidad
        } else {
            items.append(ItemCarrito(producto: producto, cantidad: cantidad))
        }
        return true
    }
    
    // TODO A2: Suma de subtotales de cada línea
    func subtotal() -> Double {
        return items.reduce(0.0) { $0 + $1.subtotal() }
    }
    
    // TODO A3: Porcentaje de descuento según tramos de subtotal
    func porcentajeDescuento() -> Double {
        let sub = subtotal()
        if sub >= 5000 {
            return 0.15
        } else if sub >= 2000 {
            return 0.10
        } else if sub >= 500 {
            return 0.05
        } else {
            return 0.0
        }
    }
    
    // Métodos auxiliares de cálculo
    func montoDescuento() -> Double {
        return subtotal() * porcentajeDescuento()
    }
    
    func subtotalConDescuento() -> Double {
        return subtotal() - montoDescuento()
    }
    
    func igv() -> Double {
        return subtotalConDescuento() * 0.18
    }
    
    func total() -> Double {
        return subtotalConDescuento() + igv()
    }
    
    // Categoría del cliente (según el subtotal)
    func categoriaCliente() -> String {
        switch Int(subtotal()) {
        case 0..<500:
            return "Regular"
        case 500..<2000:
            return "Frecuente"
        case 2000..<5000:
            return "VIP"
        default:
            return "Premium"
        }
    }
    
    // TODO A4: Suma total de unidades en el carrito
    func cantidadTotal() -> Int {
        return items.reduce(0) { $0 + $1.cantidad }
    }
    
    // TODO A5: Vaciar las líneas del carrito
    func vaciar() {
        items.removeAll()
    }
}
