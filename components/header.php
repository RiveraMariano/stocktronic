<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Stocktronic</title>
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../styles/simple-sidebar.css" rel="stylesheet" />
    <link href="../styles/index.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" />
    <!-- Bootstrap core CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Material Design Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet" />

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
</head>

<body>
    <nav class="navbar navbar-expand-md navbar-dark border-bottom">
        <button class="navbar-toggler" data-toggle="collapse" data-target="#collapse_target">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="collapse_target">
            <ul class="navbar-nav list-inline mx-auto justify-content-center">
                <li class="nav-item mt-1 mr-5">
                    <a class="navbar-brand" href="/stocktronic/pages/inicio.php">
                        <img src="../images/isotipo.svg" width="20" height="20" />
                    </a>
                </li>
                <li class="nav-item mt-1 mr-5">
                    <a class="nav-link" href="/stocktronic/pages/catalogo.php?q=1">Componentes</a>
                </li>
                <li class="nav-item mt-1 mr-5">
                    <a class="nav-link" href="/stocktronic/pages/catalogo.php?q=2">Herramientas</a>
                </li>
                <li class="nav-item mt-1 mr-5">
                    <a class="nav-link" href="/stocktronic/pages/catalogo.php?q=3">Impresoras 3D</a>
                </li>
                <li class="nav-item mt-1 mr-5">
                    <a class="nav-link" href="/stocktronic/pages/catalogo.php?q=4">Cortadores Láser</a>
                </li>
                <li class="nav-item mt-1 mr-5">
                    <a class="nav-link" href="/stocktronic/pages/catalogo.php?q=5">Raspberry Pi</a>
                </li>
                <li class="nav-item mt-1 mr-5">
                    <a class="nav-link" href="/stocktronic/pages/catalogo.php?q=6">Wireless</a>
                </li>
                <li class="nav-item mt-1 mr-5">
                    <a class="nav-link" href="/stocktronic/pages/carrito.php"><i class="fa fa-shopping-cart"></i></a>
                </li>
                <li class="nav-item mt-1 mr-5">
                    <a class="nav-link" href="/stocktronic/pages/historial.php">Historial</a>
                </li>
                <li class="nav-item">
                    <div class="dropdown">
                        <button class="btn border border-light text-light btn-sm dropdown-toggle rounded" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                            Opciones
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="/stocktronic/pages/tablaProductos.php">Tabla Productos</a>
                            <a class="dropdown-item" href="/stocktronic/pages/tablaUsuarios.php">Tabla Usuarios</a>
                            <a class="dropdown-item" href="/stocktronic/pages/tablaErrores.php">Tabla Errores</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/stocktronic/index.php" onclick="session_destroy()" style='color:red'>Cerrar Sesión</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </nav>

    <script src="../vendor/jquery/jquery.min.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <script>
        $("#menu-toggle").click(function(e) {
            e.preventDefault();
            $("#wrapper").toggleClass("toggled");
        });
    </script>

</body>