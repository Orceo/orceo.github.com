$(document).ready(
  function(){
    var r = Raphael("getting_started_graph", 800, 600);
    var targets = r.set();
    r.rect(10, 200, 200, 100).attr({fill: "hsb(0, .75, .75)", stroke: "#fff"});
    r.text(70, 250, "Publisher").attr({font: "15px Fontin-Sans, Arial", fill: "#fff", "text-anchor": "start"})


    r.rect(350, 200, 200, 100).attr({fill: "#2fbf69", stroke: "#fff"});
    r.text(400, 250, "Exchange").attr({font: "15px Fontin-Sans, Arial", fill: "#fff", "text-anchor": "start"})


    function message () {
      var c = r.circle(70, 250, 10)
      c.attr({fill: "hsb(0, .75, .75)", stroke: "#fff"});
      c.animate({ "100%": { cx: 400, easing: "bounce", opacity: 0, callback: message }}, 2000)
    }
    message()
  });
