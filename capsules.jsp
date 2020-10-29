<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Buy</title>
<link rel="stylesheet" href="css/Buy.css">
</head>
<body>
<div class="main">
	<div class="topbar1"></div>
	<div class="topbar2">
		<div class="container1">
			<div class="logout-btn">
				<a href="Logout.jsp"><b>LOGOUT</b></a>
			</div>
		</div>
	</div>
	<div class="header">
		<div class="container2">
			<div class="navbar">
				<a href="Homepage.jsp">HOME</a>
				<a href="Buydi.html">BUY</a>
                <a href="Orders.jsp">CART</a>
                <a href="ContactUs.html">CONTACT US</a>
			</div>
			<form style=" display:inline;" action ="search.jsp" method="POST">
				<input style="float:right; margin-top:8px;" type="submit" name="submit" class="submit" value="Search">
				<input style="float:right;  margin-top:8px;" type="text" placeholder="Search Here" name="search">
		 </form>
		</div>
	</div>
</div>
<div class="active">
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%
	HttpSession httpSession = request.getSession();
    String uid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
     <%
        int flag=0;
	ResultSet rs=null;
	PreparedStatement ps=null;
	java.sql.Connection conn=null;
        String ptype = "Capsule";
        String query="select p.pname,p.pid,p.manufacturer,p.mfg,p.price,p.ptype,i.quantity from product p,inventory i where p.pid=i.pid AND p.ptype =?";
        try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","root");
        ps=conn.prepareStatement(query);
        ps.setString(1,ptype);
		rs=ps.executeQuery();
		%><div class="filler2"></div>
				<div class="block">
				<%
		while(rs.next())
		{
			if(flag==4)
				{
				flag=1;
				%></div><div class="filler2"></div><%
				}
			else
			flag++;
		%>
			<div class="row">
 				<div class="column">
    				<div class="card">
    				<img src="images/pills.png" width=180 height=200>
  					<h1><%=rs.getString("pname") %></h1>
  					<p><b>ID: </b><%=rs.getString("pid") %></p>
					<p><b>Manufacturer: </b><%=rs.getString("manufacturer") %></p>
					<p><b>Mfg Date: </b><%=rs.getDate("mfg") %></p>
					<p><b>Stock: </b><%=rs.getInt("quantity") %></p>
                    <p><b>Price: </b><%=rs.getInt("price") %></p>
                    <p><b>Type: </b><%=rs.getString("ptype") %></p>
					<%if (rs.getInt("quantity")>0) 
					{
					%>
  					<form action="PlaceOrder.jsp" method="post">
  					<input type="number" name="orderquantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" placeholder="Enter quantity" max="<%=rs.getInt("quantity") %>" required >
  					<input type="hidden" name="pid" value="<%=rs.getString("pid") %>">
  					<p></p>
  					<button>Buy</button></form></div>
  					<%
  					}
  					else	
  						{
  						%>
  					
  					<button>Out Of Stock</button></div>
  					<% 
  						} 
  					%>
  				</div>
  				<%
  				}
				%>
			</div>
		<%
	}
	catch(Exception e)
	{
		out.println("error: "+e);
	}
	finally {
	    try { if (rs != null) rs.close(); } catch (Exception e) {};
	    try { if (ps != null) ps.close(); } catch (Exception e) {};
	    try { if (conn != null) conn.close(); } catch (Exception e) {};
}
	%>
</body>
</html>