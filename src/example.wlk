class Persona{
	var property sueniosPendientes
	var property sueniosCumplidos
	var edad
	var property carrerasAEstudiar
	var property carrerasRecibidas
	var property plataACobrar
	var property destinosAViajar
	var property hijos
	var property tipoPersona
	var felicidonios
	
	method cumplirSuenio(suenio){
		if(suenio.puedeCumplirSuenio(self)){
			sueniosCumplidos.add(suenio)
			felicidonios = suenio.felicidoniosPorCumplir()
		} else
		    sueniosPendientes.add(suenio)
	}
	
	method cumplirSuenioElegido(){
		tipoPersona.cumplirUnSuenio(self)
	}
	
	method cambiarTipoPersona(nuevoTipoPersona){
		tipoPersona = tipoPersona.cambiar(nuevoTipoPersona)
	}
	
	method esFeliz(){
		return felicidonios > self.felicidoniosSueniosPendientes()
	}
	
	method felicidoniosSueniosPendientes(){
		return sueniosPendientes.sum({suenio => suenio.felicidonios()})
	}
	
	method esAmbiciosa(tipoSuenio){
		return (self.sueniosAmbiciosos(tipoSuenio)).size() > 3
	}
	
	method sueniosAmbiciosos(tipoSuenio){
		return tipoSuenio.filter({suenio => suenio.felicidonios() > 100 })
	}
	
}

object personaRealista{
	
	
	method cumplirUnSuenio(persona){
		persona.cumplirSuenio(self.suenioMasImportante(persona))
	}
	
	
	method suenioMasImportante(persona){
		return (persona.sueniosPendientes()).max({suenio => suenio.felicidonios()})
	}
	
	method cambiar(nuevoTipoPersona){
		return nuevoTipoPersona
	}
	
}

object personaObsesiva{
	
	
	method cumplirUnSuenio(persona){
		persona.cumplirSuenio(self.suenioAlAzar(persona))
	}
	
	method suenioAlAzar(persona){
		return (persona.sueniosPendientes()).anyOne()
	}
	
	method cambiar(nuevoTipoPersona){
	   throw new DomainException(message = "Una persona obsesiva no puede cambiar de tipo persona")
	}
	
}

object personaAlocada{
	
	
	method cumplirUnSuenio(persona){
		persona.cumplirSuenio(self.primerSuenio(persona))
	}
	
	
	method primerSuenio(persona){
		return (persona.sueniosPendientes()).first()
	}
	
	method cambiar(nuevoTipoPersona){
	   throw new DomainException(message = "Una persona alocada no puede cambiar de tipo persona")
	}
}



class Suenios{
	
	
	
	method puedeCumplirSuenio(persona)
	
	method felicidoniosPorCumplir()
	
}

class SueniosSimples inherits Suenios{
	var felicidonios
	
	method felicidoniosPorCumplir(){
		return felicidonios
	}
	
	
	
}

class SueniosMultiples inherits Suenios{
	var suenios = []
	
	
	override method puedeCumplirSuenio(persona){
		return self.puedeCumplirTodosLosSuenios(persona)
	}
	
	override method felicidoniosPorCumplir(){
		return self.felicidoniosTotales()
	}
	
	method felicidoniosTotales(){
		return suenios.sum({suenio => suenio.felicidoniosPorCumpir()})
	}
	
	method puedeCumplirTodosLosSuenios(persona){
		return suenios.all({suenio => suenio.puedeCumplirSuenio(persona)})
	}
	

}

class RecibirseDe inherits SueniosSimples{
	var carrera
	
	override method puedeCumplirSuenio(persona){
		if(self.yaSeRecibioDe(persona)){
			throw new DomainException(message = "Ya se recibio de esa carrera!")
		}
		return self.quiereEstudiar(persona)
	}
	
	method quiereEstudiar(persona){
		return (persona.carrerasAEstudiar()).contais(carrera)
	}
	
	method yaSeRecibioDe(persona){
		return (persona.carrerasRecibidas()).contais(carrera)
	}
	
	
	
}

class ConseguirLaburo inherits SueniosSimples{
	var sueldo
	
	override method puedeCumplirSuenio(persona){
		return self.satisfaceSueldo(persona)
	}
	
	method satisfaceSueldo(persona){
		return sueldo >= persona.plataACobrar()
	}
	
}

class AdoptarHijos inherits SueniosSimples{
	var cantHijos
	
	override method puedeCumplirSuenio(persona){
		return !self.tieneHijos(persona)
	}
	
	method tieneHijos(persona){
		return persona.hijos() > 0
	}
	
}
class ViajarA inherits SueniosSimples{
	var destino
}
