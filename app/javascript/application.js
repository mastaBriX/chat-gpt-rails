// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"

$('#chat-textarea').keypress(function(e){
    if(e.which === 13){
        $(this).closest('form').submit();
    }
});
