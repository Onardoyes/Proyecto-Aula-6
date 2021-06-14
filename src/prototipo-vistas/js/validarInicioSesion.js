function validarID(evt){
	var code = (evt.which) ? evt.which : evt.keyCode;
	
	if(code==8) { // backspace.
		return true;
	} else if(code>=48 && code<=57) { // is a number.
		return true;
	} else{ // other keys.
		return false;
	}
}

function validarDatos(){
    var clave, expresion2;
    clave = document.getElementsById("password_login").value;

    expresion2 = /^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$/;
    

    if(clave === ""){
        alert("Todos los campos son obligatorios");
        return false;
    }
    else if(!expresion2.test(clave)){
        alert("La contraseña no es valida");
        return false;
    }
}