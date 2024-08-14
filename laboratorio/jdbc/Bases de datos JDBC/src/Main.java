import oracle.jdbc.proxy.annotation.Pre;

import java.io.Console;
import java.net.ConnectException;
import java.sql.*;
import java.util.Scanner;

public class Main {

    private static final String urlOracle ="jdbc:oracle:thin:@156.35.94.98:1521:DESA19";
    private static final String urlLite ="jdbc:sqlite:../bdatos";
    private static final String urlLiteExamen ="jdbc:sqlite:../Bases de datos JDBC/bd/examen.db";


    private static final String userName="UO293697";
    private static final String pass = "jorgeBs04";


    public static void main(String[] args) {
        try {
            consulta18();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }


    private static  Connection getConnection() throws SQLException {


        if(true){
            try {
                Class.forName("org.sqlite.JDBC");

            } catch (ClassNotFoundException e) {
                System.out.println(e.getMessage());
            }
            return DriverManager.getConnection(urlLiteExamen);
        }else{
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            return DriverManager.getConnection(urlOracle,userName,pass);
        }

    }

    private static void consulta1() throws SQLException {
        Connection con = getConnection();

        Statement stmt = con.createStatement();

        ResultSet rs = stmt.executeQuery("select count(*) from cines");

        rs.next();

        System.out.println("El numero de cines es: " +rs.getString(1));

        rs.close();
        stmt.close();
        con.close();
    }

    private static void consulta2() throws SQLException {
        Connection con = getConnection();

        Statement stmt = con.createStatement();

        ResultSet rs = stmt.executeQuery("select distinct  NOMBRE,APELLIDO\n" +
                "from ventas\n" +
                "join CLIENTES on ventas.DNI = CLIENTES.DNI\n" +
                "where ventas.CIFC in\n" +
                "(Select distinct CONCESIONARIOS.CIFC\n" +
                "    from DISTRIBUCION  join coches on DISTRIBUCION.CODCOCHE=COCHES.CODCOCHE\n" +
                "    join CONCESIONARIOS on DISTRIBUCION.CIFC = CONCESIONARIOS.CIFC\n" +
                "    where modelo='gti' and CIUDADC='madrid')");

        while (rs.next()) {
            System.out.println("Cliente: "+ rs.getString("nombre")+ " "+ rs.getString("apellido"));
        }

        rs.close();
        stmt.close();
        con.close();
    }

    private static void consulta3() throws SQLException {
        Connection con = getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select cifc, NOMBREC from CONCESIONARIOS where CIFC =\n" +
                "(select cifc from(select cifc, Round(avg(CANTIDAD),2) cn from DISTRIBUCION group by cifc order by cn desc fetch first row only))");

        while (rs.next()) {
            System.out.println("Concesionario con mejor promedio: " + rs.getString("cifc") + " " + rs.getString("nombrec"));
        }

        rs.close();
        stmt.close();
        con.close();
    }

    private static void consulta4() throws SQLException {
        Connection con = getConnection();
        PreparedStatement ps = con.prepareStatement("select  nombrem from ventas join marco on marco.CODCOCHE= VENTAS.CODCOCHE\n" +
                "join marcas on marco.CIFM = marcas.CIFM\n" +
                "where color  = ?");
        var linea = askOptionString("Color: ");

        ps.setString(1,linea);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            System.out.println("Marca: " + rs.getString("nombrem"));
        }

        rs.close();
        ps.close();
        con.close();

    }

    private static void consulta5() throws SQLException {
        Connection con = getConnection();

        PreparedStatement ps = con.prepareStatement("select cifc,sum(cantidad) can from DISTRIBUCION group by  CIFC having sum(cantidad)>? and sum(CANTIDAD)< ?");

        int min = askOptionInt("Valor minimo: ");
        int max = askOptionInt("Valor maximo: ");

        ps.setInt(1,min);
        ps.setInt(2,max);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            System.out.println("Concesionario: " + rs.getString("cifc")+" " +rs.getString("can"));
        }

        rs.close();
        ps.close();
        con.close();


    }

    private static void consulta6() throws SQLException {
        Connection con = getConnection();

        PreparedStatement ps = con.prepareStatement("select distinct nombre from ventas join coches on ventas.CODCOCHE = coches.CODCOCHE\n" +
                "join CONCESIONARIOS on ventas.CIFC = CONCESIONARIOS.CIFC\n" +
                "join CLIENTES on ventas.DNI = CLIENTES.DNI\n" +
                "where VENTAS.DNI not in\n" +
                "(select dni from VENTAS join concesionarios on VENTAS.CIFC = concesionarios.CIFC\n" +
                "where CIUDADC=? and COLOR=?)");

        var ciu = askOptionString("Ciudad: ");
        var color = askOptionString("Color: ");

        ps.setString(1,ciu);
        ps.setString(2,color);

        ResultSet rs = ps.executeQuery();

        System.out.print("nombre de los clientes: ");
        while (rs.next()) {
            System.out.print(rs.getString("nombre")+ " ");
        }

        rs.close();
        ps.close();
        con.close();

    }

    private static void consulta7() throws SQLException {
        Connection con = getConnection();

        CallableStatement st = con.prepareCall("{ ? = call PRACTICA1_10 (?)}");

        st.registerOutParameter(1, java.sql.Types.INTEGER);
        var value = askOptionString("Concesionario: ");
        st.setString(2,value);

        st.execute();

        var rs = st.getInt(1);

        System.out.println("Cantidad: "+ rs);

        st.close();
        con.close();

    }

    private static void consulta8() throws SQLException {
        Connection con = getConnection();

        CallableStatement st = con.prepareCall("{call PRACTICA1_ej10 (?,?)}");

        st.registerOutParameter(2, java.sql.Types.INTEGER);
        var value = askOptionString("Concesionario: ");
        st.setString(1,value);

        st.execute();

        var rs = st.getInt(2);

        System.out.println("Cantidad: "+ rs);

        st.close();
        con.close();

    }

    private static void consulta9() throws SQLException {

       Connection con = getConnection();

       Statement st = con.createStatement();
       ResultSet rst =st.executeQuery("select distinct CLIENTES.dni,NOMBRE,APELLIDO from ventas join CLIENTES on ventas.DNI = CLIENTES.DNI");//dni de los clientes


        PreparedStatement pst = con.prepareStatement("select count(*) from ventas where dni=?");//numero de coches

        PreparedStatement pst1 = con.prepareStatement("select count(distinct  cifc) from ventas where dni=?");//numero de concesionarios

        PreparedStatement coches = con.prepareStatement("select COCHES.CODCOCHE,NOMBRECH, modelo ,color from ventas join COCHES on ventas.CODCOCHE = COCHES.CODCOCHE  where dni=?");//datos del coche

        while(rst.next()){
            var dni = rst.getInt("dni");


            pst.setInt(1,dni);
            pst1.setInt(1,dni);

            ResultSet rst1 = pst.executeQuery();
            ResultSet rst2 = pst1.executeQuery();

            rst1.next(); rst2.next();

            System.out.println("Cliente: " + rst.getString(2)+" "+rst.getString(3)+ " "+rst1.getInt(1)+" "+ rst2.getInt(1));


            coches.setInt(1,dni);

            ResultSet rst3 = coches.executeQuery();

            while(rst3.next()){
                System.out.println("\t-Coche: "+rst3.getInt(1)+" "+rst3.getString(2)+" "+rst3.getString(3)+" "+rst3.getString(4));
            }

            rst3.close();
            rst2.close();
            rst1.close();

        }

        coches.close();
        pst1.close();
        pst.close();
        rst.close();
        st.close();
        con.close();


    }

    private static void consulta10() throws SQLException {
        Connection con = getConnection();

        PreparedStatement st = con.prepareStatement("insert into COCHES(codcoche, nombrech, modelo) VALUES (?, ?,?)");

        int codigo = askOptionInt("Inserta el codigo del coche: ");
        String nombre = askOptionString("Inserta el nombre: ");
        String modelo = askOptionString("Inserta el modelo: ");

        st.setInt(1,codigo);
        st.setString(2,nombre);
        st.setString(3,modelo);


        int filasAfectadas = st.executeUpdate();
        if(filasAfectadas==1){ System.out.println("Se ha añadido 1 fila correctamente");}

        st.close();
        con.close();
    }

    private static void consulta11() throws SQLException {
        Connection con = getConnection();

        PreparedStatement ps = con.prepareStatement("delete  from coches where CODCOCHE=?");

        int id = askOptionInt("Codigo del coche a elimiar: ");

        ps.setInt(1,id);

        int n = ps.executeUpdate();

        System.out.println("Se han borrado: "+n +" filas");

        ps.close();
        con.close();


    }

    private static void consulta12() throws SQLException{
        Connection con = getConnection();

        PreparedStatement ps = con.prepareStatement("update COCHES set NOMBRECH=?, MODELO=? where CODCOCHE=?");

        int codigo = askOptionInt("Inserta el codigo del coche: ");
        String nombre = askOptionString("Inserta el nombre: ");
        String modelo = askOptionString("Inserta el modelo: ");

        ps.setInt(3,codigo);
        ps.setString(1,nombre);
        ps.setString(2,modelo);

        int n = ps.executeUpdate();

        System.out.println("Se han actualizado: "+n +" filas");

        ps.close();
        con.close();
    }

    private static void consulta13() throws SQLException {
        Connection con = getConnection();

        Statement st = con.createStatement();

        ResultSet rt = st.executeQuery("select ED_NOMBRE,cantidad,EDITORIALES.ED_ID from EDITORIALES join (\n" +
                "select ED_ID,count(*) cantidad from titulos group by ED_ID) libros on libros.ED_ID= EDITORIALES.ED_ID");

        PreparedStatement ps = con.prepareStatement("select TITULOS.TITULO_ID,TITULO,count(*) autores from TITULOS join TITULOSAUTORES on TITULOS.TITULO_ID = TITULOSAUTORES.TITULO_ID\n" +
                "where ED_ID=? group by TITULOS.TITULO_ID,TITULO;");

        PreparedStatement p = con.prepareStatement("select AU_APELLIDO,AU_NOMBRE from AUTORES join TITULOSAUTORES on AUTORES.AU_ID = TITULOSAUTORES.AU_ID\n" +
                "where TITULO_ID=?");



        while(rt.next()){
            System.out.println("-Editorial: "+rt.getString(1)+" "+rt.getInt(2));

            int id = rt.getInt(3);

            ps.setInt(1,id);

            ResultSet r = ps.executeQuery();

            while(r.next()){
                System.out.println("\tTitulo: "+ r.getString(2)+" "+r.getInt(3));

                p.setInt(1,r.getInt(1));

                ResultSet a = p.executeQuery();

                while(a.next()){
                    System.out.println("\t\tAutor: "+ a.getString(1)+" "+ a.getString(2));
                }

                a.close();

            }

            r.close();
        }
        rt.close();
        st.close();
        con.close();
    }

    private static void consulta14() throws SQLException {
        Connection con = getConnection();

        PreparedStatement ps = con.prepareStatement("select ED_NOMBRE,TITULO_ID, count(TITULO_ID) libros\n" +
                "from TITULOS natural join EDITORIALES\n" +
                "where precio between ? and ?\n" +
                "group by TITULO_ID,ED_NOMBRE;");


        int min = askOptionInt("Precio minimo: ");
        int max = askOptionInt("Precio maximo: ");

        ps.setInt(1,min);
        ps.setInt(2,max);

        ResultSet r = ps.executeQuery();

        PreparedStatement ps2 = con.prepareStatement("select TITULOS.TITULO_ID, titulo,count(AU_ID) autores\n" +
                "from TITULOSAUTORES join titulos on TITULOSAUTORES.TITULO_ID = titulos.TITULO_ID\n" +
                "where TITULOS.TITULO_ID = ? group by TITULOS.TITULO_ID,TITULO");

        PreparedStatement ps3 = con.prepareStatement("select AU_APELLIDO,AU_NOMBRE\n" +
                "from TITULOSAUTORES join autores on TITULOSAUTORES.AU_ID = autores.AU_ID\n" +
                "where TITULO_ID=?");

        while(r.next()){
            System.out.println("-Editorial: "+r.getString(1)+ " "+ r.getInt("libros"));

            ps2.setInt(1,r.getInt(2));

            ResultSet r2 = ps2.executeQuery();

            ps3.setInt(1,r.getInt(2));

            ResultSet r3 = ps3.executeQuery();

            while (r2.next()){
                System.out.println("\tTitulo: "+ r2.getString("titulo")+" "+r2.getString("autores"));

                while(r3.next()){
                    System.out.println("\t\tAutor: "+ r3.getString(1)+" "+r3.getString(2));
                }

            }


            r3.close();
            r2.close();
        }

        ps3.close();
        ps2.close();
        r.close();
        ps.close();
        con.close();
    }

    private static void consulta15() throws SQLException {
        Connection con = getConnection();

        CallableStatement cs = con.prepareCall("{? = call practica1_ej11(?)}");

        cs.registerOutParameter(1, Types.INTEGER);

        var ciudad = askOptionString("Inserte la ciudad: ");

        cs.setString(2,ciudad);



        cs.execute();

        System.out.println(cs.getInt(1));


        cs.close();
        con.close();
    }

    public static void consulta16() throws SQLException {
        Connection con = getConnection();

        CallableStatement cs = con.prepareCall("{call practica3_ej3(?,?)}");

        cs.registerOutParameter(2, Types.VARCHAR);
        var codigo = askOptionInt("Codigo del editor: ");

        cs.setInt(1,codigo);

        cs.execute();

        System.out.println(cs.getString(2));
        cs.close();
        con.close();
    }

    private static void consulta17() throws SQLException {
        Connection con = getConnection();

        CallableStatement cs = con.prepareCall("{? = call practica3_ej8(?)}");

        cs.registerOutParameter(1, Types.VARCHAR);

        var codigo = askOptionString("ID: ");

        cs.setString(2,codigo);

        cs.execute();

        System.out.println(cs.getString(1));

        cs.close();
        con.close();
    }


    private static void consulta18() throws SQLException {
        Connection con = getConnection();

        Statement st = con.createStatement();

        ResultSet rt = st.executeQuery("select department.dept_name, budget,count(department.dept_name) cur,sum(credits) cre\n" +
                "from department, course\n" +
                "where course.dept_name=department.dept_name\n" +
                "and type='Compulsory' and course.dept_name not in\n" +
                "(Select course.dept_name where type<>'Compulsory') group by department.dept_name,budget\n" +
                "order by department.dept_name, cur desc");

        PreparedStatement pst = con.prepareStatement("select instructor_name, section.course_ID, title, section.sec_ID, section.semester, section.year,max_students\n" +
                "from instructor,teaches,section,course\n" +
                "where instructor.instructor_ID=teaches.instructor_ID\n" +
                "and teaches.sec_ID=section.sec_ID and teaches.semester=section.semester and teaches.year=section.year\n" +
                "and section.course_ID=course.course_ID\n" +
                "and instructor.dept_name=?\n" +
                "order by instructor_name desc");

        while(rt.next()){
            pst.setString(1,rt.getString(1));
            ResultSet rt1 = pst.executeQuery();

            System.out.println("Department: "+rt.getString(1)+" "+rt.getInt(2)+" "+ rt.getInt(3)+" "+rt.getInt(4));

            while(rt1.next()){
                System.out.println("\tInstructor/Section: "+rt1.getString(1)+" "+rt1.getInt(2)+" "+ rt1.getString(3)+" "+rt1.getInt(4)+" "+rt1.getInt(5)+" "+ rt1.getInt(6)+" "+rt1.getInt(7));
            }

            rt1.close();
        }

        pst.close();
        rt.close();
        st.close();
        con.close();

    }

    private static String askOptionString(String message){
        System.out.print("\n"+message);

        return new Scanner(System.in).nextLine();
    }

    private static int askOptionInt(String message){
        System.out.print("\n"+message);

        return new Scanner(System.in).nextInt();
    }

}
