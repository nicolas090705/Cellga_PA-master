<%-- 
    Document   : registrarvista
    Created on : 8/09/2022, 03:57:19 PM
    Author     : juanc
--%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.ConexionDB"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Declaración de las variables 
    String nombre="";
    String correo="";
    String password="";
           
    if(request.getMethod()=="GET"){
        
        //Se establecen las variables para realizar la consulta SQL
        System.out.println("*****************INSERTAR JSP**************************");
        Connection conn = ConexionDB.conectarBaseDatos();
        Statement st = null;
        ResultSet rs = null;
    
        //Se asignan valores a las variables, de acuerdo con los parametros recibidos
        nombre = request.getParameter("nombre");
        correo = request.getParameter("correo");
        password = request.getParameter("pss");
        System.out.println(nombre);
        System.out.println(correo);
        System.out.println(password);
           
        String query="";
        try{
            // Se crea un Statement, para realizar la consulta
            st = conn.createStatement();
            
            // Se arma el query
            //id de la tabla usuario es el correo
                  //INSERT INTO usuario (Usu_id, Usu_contraseña, Usu_nombre,Usu_fechaReg) values('prueba3@gmail.com','pass3','Nicolas', CURRENT_TIMESTAMP());
            query ="INSERT INTO usuario (Usu_id, Usu_contraseña, Usu_nombre,Usu_fechaReg) values('"+correo+"','"+password+"','"+nombre+"',CURRENT_TIMESTAMP());";
            out.println("<br>El Query Ejecutado es: <br>"+query);
            // Se ejecuta el query
            st.execute(query);
            
        }catch(Exception e){
            System.out.println("<br>No se pudo completar la operación: <br>"+e.getMessage()+"<br>");
            System.out.println(query);
        }
        /*
        * Se debe cerrar la conexión si o sí 
        * hay Resultset o un Statement.
        */
        finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException sqlEx) {
            } // ignore
            rs = null;
            }
            if (st != null) {
                try {
                    st.close();
                } catch (SQLException sqlEx) {
                } // ignore
                st = null;
            }
        }
        
    }
    
%>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta charset="UTF-8">
	<title></title> 
	<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, minimum-scale=1.0">
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" >
	<link rel="stylesheet" href="estilos.css">
	

</head>  
<body>
 <form class="formulario">
    
    <h1>Registrate</h1>
     <div class="contenedor">
     
     <div class="input-contenedor">
         <i class="fas fa-user icon"></i>
         <input type="text" placeholder="Nombre Completo" id="nombre" name="nombre">
         
         </div>
         
         <div class="input-contenedor">
         <i class="fas fa-envelope icon"></i>
         <input type="text" placeholder="Correo Electronico" id="correo" name="correo">
         
         </div>
         
         <div class="input-contenedor">
        <i class="fas fa-key icon"></i>
         <input type="password" placeholder="Contraseña" id="pss" name="pss">
         
         </div>
         <input type="submit" value="Registrate" class="button">
         <p>Al registrarte, aceptas nuestras Condiciones de uso y Política de privacidad.</p>
         <p>¿Ya tienes una cuenta?<a class="link" href="loginvista.jsp">Iniciar Sesion</a></p>
         <p><a class="link" href="index.jsp">Regresar </a></p>
     </div>
    </form>
</body>
</html>