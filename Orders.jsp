<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Orders</title>
<link rel="stylesheet" href="css/Orders.css">
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
			<a style="float:right;
			color:	black;
			text-decoration:none;
			padding: 10px 60px 2px 0px;
			font-weight:bold;" href="payment.html">CHECKOUT</a>
		</div>
	</div>
	</div>
	<div class="active">
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%
	HttpSession httpSession = request.getSession();
    String gid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
    
    <%
    int flag=0;
	ResultSet rs=null;
	CallableStatement cs=null;
	java.sql.Connection conn=null;
		try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","root");
		cs = conn.prepareCall("call getorders(?)");
		cs.setString(1, gid);
		rs = cs.executeQuery();
		int sum=0;
		%>
		<div class="filler2"></div>
		<h1 style="text-align:center;">CART</h1>
		<table class="tables">
			<tr>
    			<th>Order ID</th>
    			<th>Product ID</th>
    			<th>Seller ID</th>
				<th>Order Date & Time</th>
				<th>Quantity</th>
				<th>Total Price</th>
  			</tr>
		<%while(rs.next()) 
		{
			%>
	  		<% sum = sum + rs.getInt("price"); %>
  			<tr>
    			<td><%=rs.getInt("oid") %></td>
    			<td><%=rs.getString("pid") %></td>
    			<td><%=rs.getString("sid") %></td>
				<td><%=rs.getTimestamp("orderdatetime") %></td>
				<td><%=rs.getInt("quantity") %></td>
				<td><%=rs.getInt("price") %></td>
  			</tr>
  			
		<%
	}
		%>
		<tr>
			<td colspan="5" style="text-align:center;" >Total Billable Amount (in Rupees)</td>
			<td><%=sum %></td>
		</tr>
		</table>
		</div>
		<% 
	}
	catch(Exception e)
	{
		out.println("error: "+e);
	}
		finally {
		    try { if (rs != null) rs.close(); } catch (Exception e) {};
		    try { if (cs != null) cs.close(); } catch (Exception e) {};
		    try { if (conn != null) conn.close(); } catch (Exception e) {};
	}
	%>
</body>
</html>
