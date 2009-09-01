//Takeoff helpers for jQuery
jQuery.fn.extend({

  //Return the model ID for the element. Use with js_id_for helper  
  modelId: function() {
    return /_(\d+)$/.exec(this.attr('id'))[1];
  }

});
