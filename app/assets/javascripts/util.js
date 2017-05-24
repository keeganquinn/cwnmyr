$(document).ready(function() {
    $('.dropdown-menu a').click(function(event) {
        event.preventDefault();

        var checkbox = $(event.currentTarget).find('input'),
            toggled = !checkbox.prop('checked');

        setTimeout(function() {
            checkbox.prop('checked', toggled);
        }, 0);

        $(event.target).blur();

        return false;
    });
});
