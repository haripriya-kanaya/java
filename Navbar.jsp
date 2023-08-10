<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Navbar</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
         body {
  background-image: url("https://thumbs.dreamstime.com/b/admin-office-binder-wooden-desk-table-colored-pencil-pencils-pen-notebook-paper-79046621.jpg");
  background-size: cover;
  background-position: center center;
  height: 100vh;
  width: 100%;
  
}

        nav {
            background-color: #333;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
        }

        .logo {
            color: #fff;
            font-size: 1.5rem;
        }

        .nav-links {
            display: flex;
            list-style: none;
        }

        .nav-links li {
            margin-right: 20px;
        }

        .nav-links li a {
            color: #fff;
            text-decoration: none;
        }

        .burger {
            display: none;
            cursor: pointer;
        }

        .burger div {
            width: 25px;
            height: 3px;
            background-color: #fff;
            margin: 5px;
        }

        @media screen and (max-width: 768px) {
            .nav-links {
                display: none;
                flex-direction: column;
                position: absolute;
                top: 70px;
                right: 20px;
                background-color: #333;
                width: 150px;
            }

            .nav-links li {
                margin: 10px;
            }

            .burger {
                display: block;
            }
        }

        /* Additional styles for the active class when the navbar is toggled */
        .nav-links.active {
            display: flex;
        }
    </style>
</head>
<body>
    <nav>
        <div class="logo">Admin</div>
        <ul class="nav-links">
             <li><a href="Admin.jsp">Admin Search</a></li>
            <li><a href="Addadminjsp.jsp">Add Admin</a></li>
            <li><a href="Update.jsp">Slotdetails</a></li>
            <li><a href="Outtime1.jsp">Update</a></li>
            <li><a href="Login.xhtml">Logout</a></li>
            
        </ul>
        <div class="burger">
            <div class="line1"></div>
            <div class="line2"></div>
            <div class="line3"></div>
        </div>
    </nav>

    <script>
        const burger = document.querySelector('.burger');
        const navLinks = document.querySelector('.nav-links');

        burger.addEventListener('click', () => {
            navLinks.classList.toggle('active');
        });
    </script>
</body>
</html>
