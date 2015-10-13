<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" import="java.sql.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<title>Oracle Test Page</title> 
</head> 
  <body> 
<%Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
String url="jdbc:oracle:thin:@172.30.9.195:1522:orcl"; 
String user="cf"; 
String password="123123"; 
out.print(url);
Connection conn=DriverManager.getConnection(url,user,password); 
Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
String sql="select * from testvv"; 
ResultSet rs=stmt.executeQuery(sql);
%> 
<br>
<%
while(rs.next()) {
%>
| <%=rs.getString(1)%> | <%=rs.getString(2)%> |<br> 
<%}%> 
 
<%
rs.close(); 
stmt.close(); 
conn.close(); 
%>
  </body> 
</html> 