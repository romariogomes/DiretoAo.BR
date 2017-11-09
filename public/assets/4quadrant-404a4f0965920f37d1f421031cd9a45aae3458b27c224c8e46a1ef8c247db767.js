$(document).ready(function(){

  if ($(window).width() < 450) {
    $('#scatter').attr("width", "350").attr("height", "350");
  } else if ($(window).width() < 300){
    $('#scatter').attr("width", "350").attr("height", "300");
  }
  
  var svg = d3.select("#scatter"),
      margin = {top: 20, right: 20, bottom: 30, left: 50},
      width = +svg.attr("width"),
      height = +svg.attr("height"),
      domainwidth = width - margin.left - margin.right,
      domainheight = height - margin.top - margin.bottom;
    
  var x = d3.scaleLinear()
      .domain(padExtent([1,5]))
      .range(padExtent([0, domainwidth]));
  var y = d3.scaleLinear()
      .domain(padExtent([1,5]))
      .range(padExtent([domainheight, 0]));
    
  var g = svg.append("g")
      .attr("transform", "translate(" + margin.top + "," + margin.top + ")");
    
  g.append("rect")
      .attr("width", width - margin.left - margin.right)
      .attr("height", height - margin.top - margin.bottom)
      .attr("fill", "#F6F6F6");

  d3.json("../spectreData.json", function(error, data) {
    if (error) throw error;

    data.forEach(function(d) {
        d.consequence = +d.consequence;
        d.value = +d.value;
    });
        
    g.selectAll("circle")
        .data(data)
      .enter().append("circle")
        .attr("class", "dot")
        .attr("r", 7)
        .attr("cx", function(d) { return x(d.consequence); })
        .attr("cy", function(d) { return y(d.value); })
        .style("fill", function(d) {        
            if (d.value >= 3 && d.consequence <= 3) {return "#666666"} // Top Left
            else if (d.value >= 3 && d.consequence >= 3) {return "#666666"} // Top Right
            else if (d.value <= 3 && d.consequence >= 3) {return "#666666"} // Bottom Left
            else { return "#666666" } //Bottom Right         
        });

    g.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + y.range()[0] / 2 + ")")
        .call(d3.axisBottom(x).ticks(5));

    g.append("g")
        .attr("class", "y axis")
        .attr("transform", "translate(" + x.range()[1] / 2 + ", 0)")
        .call(d3.axisLeft(y).ticks(5));

    $("g.tick").remove();
  });
    
  function padExtent(e, p) {
      if (p === undefined) p = 1;
      return ([e[0] - p, e[1] + p]);
  }

  d3.select(self.frameElement).style("height", "700px");
  
  $(window).resize(function() {
    location.reload();
  });

});
