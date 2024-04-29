package bbdd.jdbc1;
import java.sql.*;
import java.util.Scanner;

import javax.naming.spi.DirStateFactory.Result;

public class Program {
	
	private static String USERNAME = "UO293697";
	private static String PASSWORD = "";
	private static String CONNECTION_STRING = "jdbc:oracle:thin:@156.35.94.98:1521:DESA19";
	
	public static void main(String[] args){
		//Ejemplos para leer por teclado
		/*
		System.out.println("Leer un entero por teclado");	
		int entero = ReadInt();
		System.out.println("Leer una cadena por teclado");	
		String cadena = ReadString();*/
		try {
			//exercise0();
			//exercise1_1();
			//exercise2();
			//exercise3();
			//exercise5_1();
			//exercise6_1();
			//exercise6_2();
			//exercise8();
			exercise9_Examen1();
		} catch (SQLException e) {
			System.err.println("SQL Exception " + e.getMessage());
			e.printStackTrace();
		}
		
	}
	
	private static Connection getConnection() throws SQLException {
		//1 registramos el driver
		DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
		
		//2 Importamos el jar
		
		//3 Crear una conexion con la base de Datos
		return DriverManager.getConnection(CONNECTION_STRING, USERNAME,PASSWORD);
	}
	
	//ejercicio 14 sql 3
	public static void exercise0() throws SQLException {
		Connection con = getConnection();
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select ed_id, avg(precio) from titulos where ed_id>2 group by ed_id having avg(precio)>60");
		
		
		while(rs.next()) {
			String resutl = rs.getString(1);
			resutl= resutl +";"+ rs.getString(2);
			System.out.println(resutl);

		}
		rs.close();
		st.close();
		con.close();
	}

	/*
		1.	Crear un metodo en Java que muestre por pantalla los resultados de las consultas 21 y 32 de la Practica SQL2. 
		1.1. (21) Obtener el nombre y el apellido de los clientes que han adquirido un coche en un concesionario de Madrid, el cual dispone de coches del modelo gti.
	 */
	public static void exercise1_1() throws SQLException {
		Connection con = getConnection();
		
		Statement st = con.createStatement();
		
		ResultSet rs = st.executeQuery("SELECT nombre, apellido\r\n"
				+ "FROM clientes\r\n"
				+ "WHERE dni IN (SELECT DISTINCT V.dni\r\n"
				+ "    FROM ventas V, coches CH, concesionarios CO, distribucion D\r\n"
				+ "    WHERE V.cifc=CO.cifc AND CO.ciudadc='madrid' AND CO.cifc=D.cifc\r\n"
				+ "        AND D.codcoche = CH.codcoche AND CH.modelo='gti')");
		
		while(rs.next()) {
			String name = rs.getString("nombre");
			
			String surname = rs.getString("apellido");
			
			System.out.println(name+";"+surname);
		}
		
		rs.close();
		st.close();
		con.close();
	}
	
	/* 
		1.2. (32) Obtener un listado de los concesionarios cuyo promedio de coches supera a la cantidad promedio de todos los concesionarios. 
	*/
	public static void exercise1_2() {
		
	}
	
	/*
		2. Crear un metodo en Java que muestre por pantalla el resultado de la consulta 6 de la Practica SQL2 de forma el color de la busqueda sea introducido por el usuario.
			(6) Obtener el nombre de las marcas de las que se han vendido coches de un color introducido por el usuario.
	*/
	public static void exercise2() throws SQLException {
		
		
		
		Connection con = getConnection();
		
		PreparedStatement ps = con.prepareStatement("SELECT DISTINCT M.nombrem\r\n"
				+ "FROM marcas M, marco R, ventas V\r\n"
				+ "WHERE M.cifm=R.cifm AND R.codcoche=V.codcoche AND V.color=?");
		
		System.out.println("Introduzca el color:");	
		String color = ReadString();
		
		ps.setString(1, color);
		
		ResultSet rs  = ps.executeQuery();
		
		while(rs.next()) {
			String name = rs.getString("nombrem");
		
			
			System.out.println(name);
		}
		
		rs.close();
		ps.close();
		con.close();
	}
	
	/*
		3.	Crear un metodo en Java para ejecutar la consulta 27 de la Practica SQL2 de forma que los limites la cantidad de coches sean introducidos por el usuario. 
			(27) Obtener el cifc de los concesionarios que disponen de una cantidad de coches comprendida entre dos cantidades introducidas por el usuario, ambas inclusive.

	*/
	public static void exercise3() throws SQLException {
		
		Connection con = getConnection();
		
		PreparedStatement ps = con.prepareStatement("SELECT cifc, sum(cantidad) AS total\r\n"
				+ "FROM distribucion\r\n"
				+ "GROUP BY cifc\r\n"
				+ "HAVING sum(cantidad)>=? AND sum(cantidad)<=?");
		
		System.out.println("Introduzca la cantidad inferior:");	
		int inf = ReadInt();
		
		System.out.println("Introduzca la cantidad superior:");	
		int sup = ReadInt();
		
		ps.setInt(1, inf);
		ps.setInt(2, sup);
		
		ResultSet rs  = ps.executeQuery();
		
		while(rs.next()) {
			String name = rs.getString("cifc");
		
			String can = rs.getString("total");
			
			System.out.println(name+": "+can);
		}
		
		rs.close();
		ps.close();
		con.close();
	}
	
	/*
		4.	Crear un metodo en Java para ejecutar la consulta 24 de la Practica SQL2 de forma que tanto la ciudad del concesionario como el color sean introducidos por el usuario. 
			(24) Obtener los nombres de los clientes que no han comprado coches de un color introducido por el usuario en concesionarios de una ciudad introducida por el usuario.

	*/
	public static void exercise4() {
		
	}
	
	/*
		5.	Crear un metodo en Java que haciendo uso de la instruccion SQL adecuada: 
		5.1. Introduzca datos en la tabla coches cuyos datos son introducidos por el usuario.

	*/
	public static void exercise5_1() throws SQLException {
		
		Connection con = getConnection();
		
		PreparedStatement ps = con.prepareStatement("insert into coches(codcoche,nombrech,modelo) values(?,?,?)");
		
		System.out.println("Introduzca codcoche:");	
		String pcodcoche = ReadString();
		System.out.println("Introduzca nombrech: ");	
		String pnombrech = ReadString();
		System.out.println("Introduzca modelo: ");	
		String pmodelo = ReadString();
		
		ps.setString(1, pcodcoche);
		ps.setString(2, pnombrech);
		ps.setString(3, pmodelo);
		
		int valores = ps.executeUpdate();
		
		System.out.println("Filas insertadas: "+ valores);
		
		
		ps.close();
		con.close();
	}
	
	/*
		5.2. Borre un determinado coche cuyo codigo es introducido por el usuario. 
	*/
	public static void exercise5_2() {
		
	}
	
	/*	 
		5.3. Actualice el nombre y el modelo para un determinado coche cuyo codigo es introducido por el usuario.
	*/
	public static void exercise5_3() {		
		
	}
	
	/*
		6. Invocar la funcion y el procedimiento del ejercicio 10 de la practica PL1 desde una aplicacion Java. 
			(10) Realizar un procedimiento y una funcion que dado un codigo de concesionario devuelve el numero ventas que se han realizado en el mismo.
		6.1. Funcion
	*/
	public static void exercise6_1() throws SQLException {		
			Connection con = getConnection();
			
			CallableStatement st = con.prepareCall("{? = call practica1_10 (?)}");
			
			System.out.println("Introduzca codigo concesionario:");	
			String cifc = ReadString();
			
			st.setString(2, cifc);
			
			st.registerOutParameter(1, java.sql.Types.INTEGER);
			
			st.execute();
			
			int resultado = st.getInt(1);
			
			System.out.print(resultado);
			
			con.close();
	}
	
	/*	
		6.2. Procedimiento
	*/
	public static void exercise6_2() throws SQLException {		
		Connection con = getConnection();
		
		CallableStatement st = con.prepareCall("{call practica1_ej10 (?,?)}");
		
		System.out.println("Introduzca codigo concesionario:");	
		String cifc = ReadString();
		
		st.setString(1, cifc);
		
		st.registerOutParameter(2, java.sql.Types.INTEGER);
		
		st.execute();
		
		int resultado = st.getInt(2);
		
		System.out.print(resultado);
		
		con.close();
	}
	
	/*
		7. Invocar la funcion y el procedimiento del ejercicio 11 de la Practica PL1 desde una aplicacion Java. 
			(11) Realizar un procedimiento y una funcion que dada una ciudad que se le pasa como parametro devuelve el numero de clientes de dicha ciudad.
		7.1. Funcion

	*/
	public static void exercise7_1() {		
			
	}	
	
	/*
		7.2. Procedimiento
	*/
	public static void exercise7_2() {		
				
	}
	
    /*
     	8. Crear un metodo en Java que imprima por pantalla los coches que han sido adquiridos por cada cliente.
     	Ademas, debera imprimirse para cada cliente el numero de coches que ha comprado y el numero de
     	concesionarios en los que ha comprado. Aquellos clientes que no han adquirido ningun coche no
		deben aparecer en el listado.
    */
	public static void exercise8() throws SQLException {		
			String	consulta = "select clientes.dni ,nombre, apellido, count (distinct cifc) nconces, count(*) nventas from clientes, ventas where clientes.dni= ventas.dni group by clientes.dni,nombre,apellido";
			
			String consulta2= "select ventas.codcoche, nombrech,modelo,color\r\n"
					+ "from ventas,coches \r\n"
					+ "where ventas.codcoche=coches.codcoche and dni=?";
			
			String color = "select count(*) from ventas where color = ?";
			
			
			
			Connection con = getConnection();
			
			Statement st = con.createStatement();
			
			ResultSet rs = st.executeQuery(consulta);
			
			ResultSet rsCo;
			ResultSet col;
			
			PreparedStatement ps = con.prepareStatement(consulta2);
			
			PreparedStatement pC = con.prepareStatement(color);
			
			while(rs.next()) {
				System.out.print("Cliente: "+rs.getString(2)+" ");
				System.out.print(rs.getString(3)+" ");
				System.out.print(rs.getInt(5)+" ");
				System.out.print(rs.getInt(4));
				System.out.print("\n");
				
				ps.setString(1, rs.getString("dni"));
				
				rsCo = ps.executeQuery();
				
				
				
				while(rsCo.next()) {
					pC.setString(1, rsCo.getString("color"));
					
					
					
					col = pC.executeQuery();
					
					col.next();
					System.out.print("---> Coches: "+ rsCo.getInt("codcoche")+" "+rsCo.getString("nombrech")+" "+rsCo.getString("modelo")+" "+rsCo.getString("color")+" "+col.getInt(1)+"\n");
					
					col.close();
				}
				
				
				
				rsCo.close();
			}
			
			pC.close();
			ps.close();
			rs.close();
			st.close();
			con.close();
			
	}
	
	public static void exercise9_Examen1() throws SQLException {
		Connection con = getConnection();
		
		String consulta = "SELECT c.codcine, sum(precio) recaudacion_cine\r\n"
				+ "FROM cines c, salas s, entradas e\r\n"
				+ "WHERE c.codcine=s.codcine AND s.codsala=e.codsala AND c.localidad=?\r\n"
				+ "GROUP BY c.codcine";
		
		String consulta2 = "SELECT p.codpelicula, p.titulo, sum(precio) recaudacion_peli\r\n"
				+ "         FROM peliculas p, entradas e, salas s\r\n"
				+ "         WHERE p.codpelicula=e.codpelicula AND e.codsala=s.codsala AND\r\n"
				+ "s.codcine= ? \r\n"
				+ "         GROUP BY p.codpelicula, p.titulo";
		
		PreparedStatement c1 = con.prepareStatement(consulta);
		
		System.out.println("Introduce el nombre de la ciudad: ");
		
		String ciudad = ReadString();
		
		c1.setString(1, ciudad);
		
		ResultSet sc1 = c1.executeQuery();
		
		ResultSet sc2;
		
		PreparedStatement c2 = con.prepareStatement(consulta2);
		
		while(sc1.next()) {
			System.out.println("Cine: "+sc1.getString("codcine")+" "+sc1.getString("recaudacion_cine"));
			
			c2.setString(1, sc1.getString("codcine"));
			
			sc2 = c2.executeQuery();
			
			while(sc2.next()) {
				System.out.println("\t"+sc1.getString("codcine")+" "+sc2.getString("titulo")+" "+ sc2.getString("recaudacion_peli"));
			}
			
			sc2.close();
		}
		
		
		c2.close();
		sc1.close();
		c1.close();
		con.close();
		
	}
		
	@SuppressWarnings("resource")
	private static String ReadString(){
		return new Scanner(System.in).nextLine();		
	}
	
	@SuppressWarnings("resource")
	private static int ReadInt(){
		return new Scanner(System.in).nextInt();			
	}	
}
