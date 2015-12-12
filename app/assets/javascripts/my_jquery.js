// Caso tenha algum alerta, irá aparecer na tela
// Se esse alerta for clicado, ele irá fechar
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