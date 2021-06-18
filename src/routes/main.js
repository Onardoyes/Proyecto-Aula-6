const express = require('express');
const { Router } = require('express');
const router = Router();
const nodemailer = require('nodemailer');
const mainController = require('../controllers/mainController');

//Router inicio de sesion
router.get('/', mainController.listInicio);

//Routers de usuarios
router.get('/list', mainController.list);
router.post('/add', mainController.save);
router.get('/delete/:id_empleado', mainController.delete);
router.get('/update/:id_empleado', mainController.edit);
router.post('/update/:id_empleado', mainController.update);

//routers reportes
router.get('/reportes', mainController.renderReporte);
router.post('/addReportes', mainController.saveReporte);

//router almacen
router.get('/almacen', mainController.listInventario);
router.get('/delete/:id_ingrediente', mainController.deleteInventario);
router.post('/update/:id_ingrediente', mainController.updateInventario);

//router ordenes
router.get('/ordenes', mainController.listOrdenes);
router.post('/addOrdenes', mainController.saveOrdenes);


module.exports = router;