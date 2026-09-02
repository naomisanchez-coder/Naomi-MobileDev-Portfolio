import Foundation

//
// EJERCICIO 1: PLAN DE PAGO BÁSICO (COMPRA A CRÉDITO)
//
do {
    // --- Entradas ---
    let producto: String = "Smart TV 55 Pulgadas" // Nombre del producto
    let precioUnitario: Double = 1500.00          // Precio unitario en soles
    let cantidad: Int = 2                         // Cantidad de productos comprados
    let planMeses: Int = 6                        // Plan elegido: 6, 12 o 24 meses
    
    // --- Cálculos iniciales ---
    let montoTotalCompra = precioUnitario * Double(cantidad) // Monto total base
    
    // Determinar tasa de interés según el plan elegido
    var porcentajeInteres: Double = 0.0
    if planMeses == 6 {
        porcentajeInteres = 0.20 // 20% de interés
    } else if planMeses == 12 {
        porcentajeInteres = 0.40 // 40% de interés
    } else if planMeses == 24 {
        porcentajeInteres = 0.60 // 60% de interés
    }
    
    let montoInteres = montoTotalCompra * porcentajeInteres  // Valor total en soles del interés
    let montoFinanciado = montoTotalCompra + montoInteres   // Monto final a pagar a crédito
    let cuotaMensual = montoFinanciado / Double(planMeses)   // Valor de cada cuota mensual
    
    // --- Cabecera del resumen ---
    print("==================================================================")
    print("                       PLAN DE PAGO BÁSICO                        ")
    print("==================================================================")
    print("Producto: \(producto)")
    print("Monto Compra: S/.\(String(format: "%.2f", montoTotalCompra)) | Interés: S/.\(String(format: "%.2f", montoInteres))")
    print("Monto Financiado: S/.\(String(format: "%.2f", montoFinanciado)) | Cuota M.: S/.\(String(format: "%.2f", cuotaMensual))")
    print("------------------------------------------------------------------")
    print("MES\t\tMONTO INICIAL\t\tCUOTA MENSUAL\t\tRESTA X PAGO")
    print("------------------------------------------------------------------")
    
    // --- Generación de la tabla de cuotas ---
    var saldoPendiente = montoFinanciado
    
    for mes in 1...planMeses {
        let montoInicial = saldoPendiente
        let restaXPago = montoInicial - cuotaMensual
        
        print("\(mes)\t\tS/.\(String(format: "%.2f", montoInicial))\t\tS/.\(String(format: "%.2f", cuotaMensual))\t\tS/.\(String(format: "%.2f", max(0, restaXPago)))")
        
        saldoPendiente = restaXPago // Actualiza el saldo restante para el próximo mes
    }
    print("==================================================================\n\n")
}


//
// EJERCICIO 2: PLAN DE PAGO CON VALIDACIÓN, FECHAS Y PAGO ADELANTADO
//
do {
    // --- Entradas ---
    let producto: String = "Laptop Pro"          // Nombre del producto
    let precioUnitario: Double = 3500.00        // Precio unitario
    let cantidad: Int = 1                       // Cantidad
    let planMeses: Int = 12                     // Plan elegido (6, 12, 24)
    
    let mesPagoAdelantado: Int = 3              // Mes en el que abonará dinero extra (0 = ninguno)
    let montoAdicional: Double = 1000.00        // Monto extra a amortizar en ese mes
    
    // --- Validación del Plan de Pago ---
    if planMeses != 6 && planMeses != 12 && planMeses != 24 {
        print("ERROR: El plan de pago de \(planMeses) meses no es válido. Debe elegir 6, 12 o 24.")
    } else {
        // --- Cálculos principales ---
        let montoTotalCompra = precioUnitario * Double(cantidad)
        
        var porcentajeInteres: Double = 0.0
        switch planMeses {
        case 6:  porcentajeInteres = 0.20
        case 12: porcentajeInteres = 0.40
        case 24: porcentajeInteres = 0.60
        default: porcentajeInteres = 0.0
        }
        
        let montoInteres = montoTotalCompra * porcentajeInteres
        let montoFinanciado = montoTotalCompra + montoInteres
        let cuotaRegular = montoFinanciado / Double(planMeses)
        
        print("=================================================================================")
        print("                 PLAN DE PAGO CON AMORTIZACIÓN Y FECHAS                          ")
        print("=================================================================================")
        print("Producto: \(producto) | Plan: \(planMeses) meses")
        print("Monto Compra: S/.\(String(format: "%.2f", montoTotalCompra)) | Monto Financiado: S/.\(String(format: "%.2f", montoFinanciado))")
        print("---------------------------------------------------------------------------------")
        print("MES\tFECHA\t\tMONTO INICIAL\tPAGO TOTAL\tRESTA POR PAGAR")
        print("---------------------------------------------------------------------------------")
        
        // --- Configuración de fechas ---
        let formateadorFecha = DateFormatter()
        formateadorFecha.dateFormat = "dd/MM/yyyy"
        var fechaActual = formateadorFecha.date(from: "26/09/2026") ?? Date() // Fecha de inicio fijada
        
        var saldoPendiente = montoFinanciado
        var mesesRealmentePagados = 0
        
        for mes in 1...planMeses {
            if saldoPendiente <= 0 { break } // Si la deuda ya está pagada en su totalidad, se corta el bucle
            
            mesesRealmentePagados += 1
            let montoInicial = saldoPendiente
            
            // Calcular pago del mes (revisar si aplica abono adicional)
            var pagoEsteMes = cuotaRegular
            if mes == mesPagoAdelantado {
                pagoEsteMes += montoAdicional
            }
            
            // Ajustar pago si sobrepasa la deuda restante
            if pagoEsteMes > montoInicial {
                pagoEsteMes = montoInicial
            }
            
            let restaPorPagar = montoInicial - pagoEsteMes
            let fechaString = formateadorFecha.string(from: fechaActual)
            
            print("\(mes)\t\(fechaString)\tS/.\(String(format: "%.2f", montoInicial))\tS/.\(String(format: "%.2f", pagoEsteMes))\tS/.\(String(format: "%.2f", max(0, restaPorPagar)))")
            
            saldoPendiente = restaPorPagar
            
            // Avanzar aproximadamente 1 mes en la fecha
            if let nuevaFecha = Calendar.current.date(byAdding: .month, value: 1, to: fechaActual) {
                fechaActual = nuevaFecha
            }
        }
        
        print("---------------------------------------------------------------------------------")
        print("RESULTADO FINAL: Meses Pagados \(mesesRealmentePagados) De \(planMeses)")
        print("=================================================================================")
    }
}
