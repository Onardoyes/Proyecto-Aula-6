anychart.onDocumentLoad(function () {
  // Crear una instancia de la frafica de pastel
  var chart = anychart.pie();
  // Poner los datos
    chart.data([
    ["Chocolate", 5],
    ["Rhubarb compote", 2],
    ["Crêpes Suzette", 2],
    ["American blueberry", 2],
    ["Buttermilk", 1]
  ]);
  // Poner el titulo de la grafica
  chart.title("Top 5 rellenos de pastel");
  // Poner el elemento que la contiene
  chart.container("contenido");
  // Inicializar la visualización de la grafica
  chart.draw();
});

anychart.onDocumentReady(function () {
    var chart = anychart.line();

    var lineSeries = chart.column([
        {x: 'Enero', value: 2},
        {x: 'Febrero', value: 5},
        {x: 'Marzo', value: 3},
        {x: 'Abril', value: 9},
        {x: 'Mayo', value: 4}
    ]);

    var title = chart.title();
    title.enabled(true);
    title.text('Da clic en las barras');

    var counter = 0;

    // Poner el listener
    lineSeries.listen('pointClick', function (e) {
        counter++;
        title.text('Diste clic ' + counter + ' veces. Da clic otra vez');
    });

    chart.container('contenido');
    chart.draw();
});

anychart.onDocumentReady(function () {

  // Tipo de grafica
  var chart = anychart.line();

  // Titulo de la grafica
  chart.title("Grafica de lineas Escala de tiempo");

  // Crear escala logaritmica personalizada
  var logScale = anychart.scales.log();
  logScale.minimum(1);

  // Aplicar la escala personalizada to y scale
  chart.yScale(logScale);

  // Crear escala de tiempo personalizada
  var dateTimeScale = anychart.scales.dateTime();
  var dateTimeTicks = dateTimeScale.ticks();
  dateTimeTicks.interval(0, 6);

  // Aplicar escala de tiempo
  chart.xScale(dateTimeScale);

  var series = chart.line([
    {value: 1.172, x: Date.UTC(2003, 09, 14)},
    {value: 1.916, x: Date.UTC(2004, 09, 13)},
    {value: 5.57, x: Date.UTC(2005, 09, 13)},
    {value: 15.0, x: Date.UTC(2006, 09, 13)},
    {value: 144, x: Date.UTC(2007, 09, 13)}
  ]);

  // Ajustar herramientas
  var tooltip = series.tooltip();
  tooltip.format(function () {
    var value = (this.value).toFixed(0);
    var date = new Date(this.x);
    var options = {year: "numeric", month: "numeric", day: "numeric"};
    var transformedDate =  date.toLocaleDateString("en-US", options);

    return "Value: $" + value + " mil.\n" + transformedDate ;
  });

  // Ajustar el alineamiento del eje
  var labels = chart.xAxis().labels();
  labels.hAlign("center");
  labels.width(60);
  labels.format(function(value){
    var date = new Date(value["tickValue"]);
    var options = {
      year: "numeric",
      month: "short"
    };
    return date.toLocaleDateString("en-US", options);
  });

  // Poner elemento que contiene la grafica e inicializarla
  chart.container("contenido");
  chart.draw();
});

