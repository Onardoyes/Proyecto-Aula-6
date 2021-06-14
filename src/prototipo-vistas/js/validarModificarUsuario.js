function validarDatos(){
    var nombre, apellidop, apellidom, expresion2;
    nombre = document.getElementsByName("usuario").Value;    
    apellidop = document.getElementsByName("apellidoPat").Value;
    apellidom = document.getElementsByName("apellidoMat").Value;
    clave1 = document.getElementsByName("contrasena").Value;
    clave2 = document.getElementsByName("confirmar_contrasena").Value;

    expresion2 = /^(?=\\w*\\d)(?=\\w*[A-Z])(?=\\w*[a-z])\\S{8,16}$/;
    

    if(nombre === "" || apellidom === "" || apellidop === ""){
        alert("todos los campos son obligatorios");
        return false;
    }
   else if(!expresion.test(nombre)){
        alert("El nombre no es valido");
        return false;
   }
   else if(!expresion.test(apellidom)){
        alert("El apellido materno no es valido");
        return false;
    }
    else if(!expresion.test(apellidop)){
        alert("El apellido paterno no es valido");
        return false;
    }
}

function validarContraseña(){
    var clave1, clave2, expresion2;
    clave1 = document.getElementsByName("contrasena").Value;
    clave2 = document.getElementsByName("confirmar_contrasena").Value;

    expresion2 = /^(?=\\w*\\d)(?=\\w*[A-Z])(?=\\w*[a-z])\\S{8,16}$/;
    

    if(clave1 === "" || clave2 === ""){
        alert("todos los campos son obligatorios");
        return false;
    }
    else if(!expresion2.test(clave1)){
        alert("La contraseña no es valida");
        return false;
    }
    else if(clave2 !== clave1){
        alert("Las contraseñas ingresadas son diferentes entre si");
        return false;
    }
    else if(!expresion2.test(clave2)){
        alert("La contraseña no es valida");
        return false;
    }
}