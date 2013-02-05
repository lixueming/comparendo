$(document).ready(function(){
    var minCharactersLength = 2;
    $('#search-field').autocomplete({
        source: $('#search-field').data('autocomplete-source'),
        minLength: minCharactersLength,
        select: function( event, ui ) {
            /*removing the word of the ui.item.value which is either (company) or (tag) or (article)
            * It is in order to insert it in search-field
            * NOT used for search page
            * */
            var pureLabel = ui.item.label.replace(/ \(company\)| \(tag\)| \(article\)/g,"") ;
            $('#search-field').val(pureLabel);
            event.preventDefault();
            window.location.href = ui.item.value;
        }
    });

    $('#industry').autocomplete({
        source: $('#industry').data('autocomplete-source'),
        minLength: minCharactersLength,
        select: function( event, ui ) {
            var pureLabel = ui.item.label.replace(/ \(company\)| \(tag\)/g,"") ;
            $('#industry').val(pureLabel);
            event.preventDefault();
        },
        zIndex: 9999
    });

    $('#area').autocomplete({
        source: $('#area').data('autocomplete-source'),
        minLength: minCharactersLength,
        select: function( event, ui ) {
            //debugger;
            var pureLabel = ui.item.label.replace(/ \(region\)| \(city\)/g,"") ;
            $('#area').val(pureLabel);
            event.preventDefault();
        },
        zIndex: 9999
    });
});

