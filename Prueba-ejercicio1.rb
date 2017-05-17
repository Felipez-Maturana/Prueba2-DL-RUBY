def obtenerMatriz()
	archivoAlmacen = File.open("notas.csv","r")
	contenido=[]

	archivoAlmacen.each_line do |line|
		contenido.push(line.chomp.split(", ")) 
	end
	archivoAlmacen.close()

	# print contenido
	return contenido
end

def obtenerPromedioAlumnos()
	alumnos = obtenerMatriz()
	notas=[]
	i=0
	while(i<alumnos.length)
		promedio=0
		j=1
		while(j<alumnos[i].length)
			if(alumnos[i][j].to_i.is_a? Numeric)
				promedio+=alumnos[i][j].to_i
			else
				promedio+=0
			end
			j+=1
		end
		promedio = promedio/(alumnos[i].length-1)
		notas.push([alumnos[i][0],promedio])
		i+=1
	end


	# print notas

	i=0
	# while(i<notas.length)
	# 	archivoAlumno = File.open(notas[i][0].to_s+".txt","w")
	# 	archivoAlumno.puts("El alumno #{notas[i][0]} posee un promedio = #{notas[i][1]}")	
	# 	i+=1
	# end
	archivoAlumno = File.open("PromedioAlumnos.txt","w")
	while(i<notas.length)
		archivoAlumno.puts("El alumno #{notas[i][0]} posee un promedio = #{notas[i][1]}")	
		i+=1
	end

	return notas
end


def cantidadInasistencias()
	alumnos = obtenerMatriz()

	i=0
	inasistencias=0
	while(i<alumnos.length)
		j=1
		while(j<alumnos[i].length)
			if(alumnos[i][j]=="A")
				inasistencias+=1
			end
			j+=1
		end
		i+=1
	end

	# puts inasistencias
	return inasistencias
end

def aprobados(notaAprobar =5)
	promediosAlumno=obtenerPromedioAlumnos()
	alumnosAprobados=[]
	i=0
	while(i<promediosAlumno.length)
		if(promediosAlumno[i][1] >=notaAprobar )
			alumnosAprobados.push(promediosAlumno[i][0])
		end
		i+=1
	end

	if(alumnosAprobados.length>0 )
		puts "Los alumnos aprobados son: "
		alumnosAprobados.each do |alum|
			puts "#{alum}"		
		end
	else
		puts "Lamentablemente, no existen alumnos aprobados"
	end

end




opcion =0
while(opcion != 4)
	puts "##########################MENU##########################"
	puts "1: Generar archivo con nombres y promedio"
	puts "2: Contar cantidad de inasistencias"
	puts "3: Alumnos que aprobaron"
	puts "4: Salir"
	opcion = gets.chomp.to_i

	if (opcion >= 1 && opcion <= 4)
		case opcion
		when 1
			puts "El archivo se ha generado correctamente en el directorio junto al cOdigo con el nombre PromdioAlumnos.txt"
			obtenerPromedioAlumnos()
		when 2
			inasistencias = cantidadInasistencias
			puts "La cantidad total de asistencias es #{inasistencias}"
		when 3
			puts "Ingrese la nota mInima para aprobar (entre 0 y 10)"
			notaMin=gets.chomp
			if(notaMin.eql?"")
				puts "por defecto"
				aprobados()
			else
				aprobados(notaMin.to_i)
			end
		when 4
			puts"Cerrando Sesión, el programa ha finalizado correctamente."
		end
	else
		puts "opción inválida, por favor, intente nuevamente."
	end
	puts "#########################################################"

end