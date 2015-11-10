$( document ).ready(function() {
    var noticesBox = $('div.notices');

    if (noticesBox.text().trim()){
      noticesBox.show();
    } 

    noticesBox.click(function(){
      noticesBox.hide();
    });
});