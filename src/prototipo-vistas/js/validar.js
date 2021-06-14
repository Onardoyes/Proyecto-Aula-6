function validarDatos(){
    var nombre, apellidop, apellidom, clave, expresion, expresion2;
    nombre = document.getElementById("nombre").Value;    
    apellidop = document.getElementById("apellidop").Value;
    apellidom = document.getElementById("apellidom").Value;
    clave = document.getElementById("clave").Value;

    expresion2 = /^(?=\\w*\\d)(?=\\w*[A-Z])(?=\\w*[a-z])\\S{8,16}$/;
    expresion = /^[a-zA-Z]{3,30}$/;
    

    if(nombre === "" || apellidom === "" || apellidop === "" || clave == ""){
        alert("todos los campos son obligatorios");
        return false;
    }
   else if(!expresion.test(nombre)){
        alert("el nombre no es valido")
        return false;
   }
   else if(!expresion.test(apellidom)){
        alert("el apellido materno no es valido")
        return false;
    }
    else if(!expresion.test(apellidop)){
        alert("el apellido paterno no es valido")
        return false;
    }
    else if(!expresion2.test(clave)){
        alert("la contraseña no es valida")
        return false;
    }
}