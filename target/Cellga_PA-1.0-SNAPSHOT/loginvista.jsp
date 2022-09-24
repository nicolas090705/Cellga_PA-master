<%-- 
    Document   : loginvista
    Created on : 8/09/2022, 03:55:16 PM
    Author     : juanc
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.ConexionDB"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%--
    PASO 3: Se reciben los parametros que se ingresaron por el formulario form_sesion
--%>
<%
    System.out.println("PRUEBA PARA ACTUALIZAR GIT");
    String correo_in = request.getParameter("campo_correo");
    String pass_in = request.getParameter("campo_pass");
    
    Connection conn = ConexionDB.conectarBaseDatos();
    Statement st = null;
    ResultSet rs = null;
    
    String query="";
    try{
        // Se crea un Statement, para realizar la consulta
        st = conn.createStatement();
        
        // Se arma el query
        
        query ="SELECT Usu_id, Usu_contraseña FROM usuario WHERE Usu_id = '"+correo_in+"' AND Usu_contraseña ='"+pass_in+"';";
        //out.println("<br>El Query Ejecutado es: <br>"+query);
        // Se ejecuta el query
            
        rs = st.executeQuery(query);
            
        String vCorreo="";
        String vPss="";
           
        while(rs.next()){
            vCorreo =rs.getString("Usu_id");
            vPss = rs.getString("Usu_contraseña");
        }
                        
        /*
        out.println("form "+user_in);
        out.println("form "+pass_in);
        out.println("query "+vUsuario);
        out.println("query "+vPss);
        */
        //if(vCorreo==correo_in && vPss==pass_in){
        if(correo_in.equals(vCorreo) && vPss.equals(pass_in)){
            out.println("primier if");
            /*Se crea la sesion*/
            HttpSession sesion = request.getSession();
            /*Se agregan atributos a la sesión*/
                
            sesion.setAttribute("password",pass_in);
            sesion.setAttribute("user", correo_in);
                
            /*A manera de prueba se muestran los datos de la sesion*/
                        
            String password = (String)sesion.getAttribute("password");
            String usuario = (String)sesion.getAttribute("user"); 
//                
//            out.println("<br>Se ha establecido una sesión con los siguientes datos:<br>");
//            out.println("<br>password: "+password);
//            out.println("<br>usuario: "+usuario);
//               
//            out.println("<br><br><a href='./bienvenida.jsp'>Mostrar bienvenida</a>");
//        
        }else{
            out.println("<br>La sesión no pudo ser iniciada, intente nuevamente");
            out.println("<br><br><a href='..../index.html'>Regresar a index.html</a>");
        }
    
    }catch(Exception e){
        out.println("<br>No se pudo completar la operación: <br>"+e.getMessage()+"<br>");
        out.println(query);
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
    
    <h1>Login</h1>
     <div class="contenedor">
     
     
         
         <div class="input-contenedor">
         <i class="fas fa-envelope icon"></i>
         <input type="text" placeholder="Correo Electronico" name="campo_correo" id="campo_correo">
         
         </div>
         
         <div class="input-contenedor">
        <i class="fas fa-key icon"></i>
         <input type="password" placeholder="Contraseña" name="campo_pass" id="campo_pass">
         
         </div>
         <input type="submit" value="Login" class="button">
         <p>Al registrarte, aceptas nuestras Condiciones de uso y Política de privacidad.</p>
         <p>¿No tienes una cuenta? <a class="link" href="registrarvista.jsp">Registrate </a></p>
         <p><a class="link" href="index.jsp">Regresar </a></p>
     </div>
    </form>
</body>
</html>