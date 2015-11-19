$( document ).ready(function() {
    var noticesDiv = $('div.notices'),
        notice = $('p.notice'),
        alert = $('p.alert');

    if (notice.text().trim()) {
      noticesDiv.show();
      noticesDiv.addClass('notice-good');
    } else if (alert.text().trim()) {
      noticesDiv.show();
      noticesDiv.addClass('notice-bad');
    }

    noticesDiv.click(function() {
      noticesDiv.hide();
    });
});