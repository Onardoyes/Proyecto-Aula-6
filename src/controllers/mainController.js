const express = require('express');
const { Router } = require('express');
const router = Router();
const nodemailer = require('nodemailer');

const controller = {};

//Controllers de inicio de sesion
controller.listInicio = (req, res) => {
    req.getConnection((err, conn) => {
        conn.query('SELECT * FROM marisco.empleado', (err, empleados) => {
            if(err){
                res.json(err);
            }
            console.log(empleados);
            res.render('inicioSesion', {
                data: empleados
            });
        });
    });
};

//Controllers de usuarios
controller.list = (req, res) => {
    req.getConnection((err, conn) => {
        conn.query('SELECT * FROM marisco.empleado', (err, empleados) => {
            if(err){
                res.json(err);
            }
            console.log(empleados);
            res.render('usuarios', {
                data: empleados
            });
        });
    });
};

controller.save = (req, res) => {
    const data = req.body;
    req.getConnection((err, conn) => {
        conn.query('INSERT INTO marisco.empleado set ?', [data], (err, empleado) => {
            if(err){
                res.json(err);
            }
            console.log(empleado);
            res.redirect('/');
            
        });
    })
};

controller.edit = (req, res) => {
    const { id_empleado } = req.params;
    req.getConnection((err, conn) => {
        conn.query('SELECT * FROM marisco.empleado WHERE id_empleado = ?', [id_empleado], (req, empleado) =>{
            res.render("usuarios_edit", {
                data: empleado[0]
            });
        });
    });
};

controller.update = (req, res) => {
    const { id_empleado } = req.params;
    const newEmpleado = req.body;
    req.getConnection((err, conn) => {
        conn.query('UPDATE marisco.empleado set ? where id_empleado = ?', [newEmpleado, id_empleado], (err, rows) => {
            res.redirect('/');
        });
    });
};

controller.delete = (req, res) => {
    const { id_empleado } = req.params;
    req.getConnection((err, connection) => {
      connection.query('DELETE FROM marisco.empleado WHERE id_empleado = ?', [id_empleado], (err, rows) => {
        res.redirect('/');
      });
    });
};

//controllers de reporte
controller.renderReporte = (req, res) => {
    req.getConnection((err, conn) => {
        conn.query('SELECT * FROM marisco.reporte', (err, reportes) => {
            if(err){
                res.json(err);
            }
            console.log(reportes);
            res.render('reportes', {
                data: reportes
            });
        });
    });
};

controller.saveReporte = (req, res) => {
    const data = req.body;
    req.getConnection((err, conn) => {
        conn.query('INSERT INTO marisco.reporte VALUES (0,?,?,?,?)', [data.id_empleado, data.id_prioridad, data.reporte_descripcion, data.fecha_reporte], (err, reporte) => {
            if(err){
                res.json(err);
            }
            console.log(reporte);
        });
    });

    const {id_empleado, id_prioridad, fecha_reporte, email, reporte_descripcion} = req.body;
    
    //Pasa los datos por la consola
    contentHTML = `
    <h1>Reporte SeaFood</h1>
    <ul>
        <li>ID Empleado: ${id_empleado}</li>
        <li>ID Prioridad: ${id_prioridad}</li>
        <li>Fecha: ${fecha_reporte}</li>
        <li>Email: ${email}</li>
    </ul>
    <p>Mensaje: ${reporte_descripcion}</p>`;
    console.log(contentHTML);
    

    // create reusable transporter object using the default SMTP transport
    const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        port: 465,
        secure: true, // true for 465, false for other ports
        auth: {
        user: '', // generated ethereal user
        pass: '', // generated ethereal password
        },
    });

    const info = transporter.sendMail({
        from: "'SeaFood Support' <aaa@gmail.com>",
        to: `${email}`,
        subject: 'Reporte SeaFood',
        html: contentHTML
    });
    console.log('email enviado');
    res.redirect('/reportes');
};

//controllers de inventario
controller.listInventario = (req, res) => {
    req.getConnection((err, conn) => {
        conn.query('SELECT despensa.id_ingrediente, cat_ingrediente.nombre_ingrediente, despensa.fecha_ingreso, despensa.id_unidad_medida, despensa.cantidad_inicial, despensa.cantidad_disponible FROM despensa, cat_ingrediente WHERE despensa.id_ingrediente = cat_ingrediente.id_ingrediente;', (err, despensa) => {
            if(err){
                res.json(err);
            }
            console.log(despensa);
            res.render('almacen', {
                data: despensa
            });
        });
    });
};

controller.updateInventario = (req, res) => {
    const { cantidad_disponible } = req.params;
    const { id_ingrediente} = req.params;
    req.getConnection((err, conn) => {
        conn.query('UPDATE marisco.despensa set despensa.cantidad_inicial=? where despensa.id_ingrediente = ?', [cantidad_disponible, id_ingrediente], (err, rows) => {
            res.redirect('/');
        });
    });
};

controller.deleteInventario = (req, res) => {
    const { id_ingrediente } = req.params;
    req.getConnection((err, connection) => {
      connection.query('DELETE FROM marisco.despensa WHERE id_ingrediente = ?', [id_ingrediente], (err, rows) => {
        res.redirect('/');
      });
    });
};

//Controllers ordenes
controller.listOrdenes = (req, res) => {
    req.getConnection((err, conn) => {
        conn.query('SELECT * FROM marisco.orden', (err, orden) => {
            if(err){
                res.json(err);
            }
            console.log(orden);
            res.render('comandas', {
                data: orden
            });
        });
    });
};

controller.saveOrdenes = (req, res) => {
    const data = req.body;
    req.getConnection((err, conn) => {
        conn.query('INSERT INTO marisco.orden set ?', [data], (err, orden) => {
            if(err){
                res.json(err);
            }
            console.log(orden);
            res.redirect('/detalleOrden');
            
        });
    })
};

//controllers detalle orden
controller.listOrdenDetalle = (req, res) => {
    req.getConnection((err, conn) => {
        conn.query('SELECT * FROM marisco.detalle_orden', (err, detalleOrden) => {
            if(err){
                res.json(err);
            }
            console.log(detalleOrden);
            res.render('detalleOrden', {
                data: detalleOrden
            });
        });
    });
};

module.exports = controller;