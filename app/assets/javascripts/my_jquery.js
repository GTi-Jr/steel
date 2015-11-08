$( document ).ready(function() {
    var noticesBox = $('div.notices');

    if (!(noticesBox.text() === '')){
      noticesBox.show();
    } else {
      noticeBox.hide();
    }

    noticesBox.click(function(){
      noticesBox.hide();
    });
});