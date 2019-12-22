

<%@page import="com.secure.kk.action.Dbconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Secure_Dynamic_Multi</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/style.css" type="text/css"/>
        <script src="js/jquery.min.js" type="text/javascript"></script>
    </head>
    <body>
        <div id="main">
            <div id="header">
                <center><h1>A Secure and Dynamic Multi-keyword Ranked Search <br />Scheme over Encrypted Cloud Data</h1></center>
                <div id="menu">
                    <ul>
                        <li class="first"><a href="user.jsp" title="">Home</a></li>
                        <li><a href="#" id="search" title="">File Search</a></li>
                        <li><a href="#" id="user" title="">File Download</a></li>
                        <li><a href="#" id="cloud" title="">Password</a></li>
                        <li><a href="index.jsp"  title="">Logout</a></li>
                    </ul>
                </div>
            </div>
            <div id="container"><br />
                <div  style="width: 1000px;height:  400px;margin-left: 200px;border-radius: 20px;margin-top: 10px;background: white">
                    <center><h2>Search Results</h2></center>
                        <%
                            Connection con = null;
                            Statement st = null;
                            ResultSet rs = null;
                            ResultSet rs1 = null;
                            String f = null;
                            String k1 = null;
                            String k2 = null;
                            String k3 = null;
                            String owner = null;
                            String uname = session.getAttribute("umail").toString();
                            String fname = request.getParameter("fname");
                            String fname1 = request.getParameter("fname1");
                            String fname2 = request.getParameter("fname2");
                            String skey = request.getParameter("skey");
                            try {
                                con = Dbconnection.getConnection();
                                st = con.createStatement();
                                rs1 = st.executeQuery("select * from reg where Email='" + uname + "' AND skey='" + skey + "' AND role='User'");
                                if (rs1.next()) {
                                    rs = st.executeQuery("select * from files where keyword1='" + fname + "' or keyword2='" + fname + "' or keyword3='" + fname + "' or keyword1='" + fname1 + "' or keyword2='" + fname1 + "' or keyword3='" + fname1 + "' or keyword1='" + fname2 + "' or keyword2='" + fname2 + "' or keyword3='" + fname2 + "' or  filetype='" + fname + "' or filename='" + fname + "' order by frank desc");
                                    while (rs.next()) {
                                        f = rs.getString("filename");
                                        k1 = rs.getString("keyword1");
                                        k2 = rs.getString("keyword2");
                                        k3 = rs.getString("keyword3");
                                        owner = rs.getString("owner");
                        %>  
                    <center><a href="ranking.jsp?<%=uname%>,<%=f%>,<%=k1%>,<%=k2%>,<%=k3%>,<%=owner%>" style="font-size: 20px;color: red;text-decoration: none"><%=f%></a></center><br />
                        <% }
                            } else {
                                response.sendRedirect("user.jsp?msgg=failed");
                            }%>
                        <%if (!(fname.equalsIgnoreCase(k1)) &&  !(fname.equalsIgnoreCase(k2)) && !(fname.equalsIgnoreCase(k3))) {%>
                    <label style="margin-left: 10px;font-size: 18px;color: red">Your search - <label style="color: blue"><%=fname%></label>- did not match any documents.</label><br /><br /><br />
                    <label style="margin-left: -100px;font-size: 18px;color: #0000cc">Suggestions:</label><br />
                    <ul style="margin-left: 10px;font-size: 18px;color: #0000cc"><br />
                        <li>Make sure that all words are spelled correctly.</li>
                        <li>Try different keywords.</li>
                        <li>Try more general keywords.</li>
                    </ul>
                    <% }
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }

                    %>
                </div>
            </div>
            <div id="footer"><br /><br />
            
            </div>
        </div>
    </body>
</html>

