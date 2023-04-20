import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
    connect() {
        $("#chat-form").bind("turbo:submit-end", () => {
            $('#chat-textarea').val('');
        })

        $(document).on('keydown', '#chat-textarea', function (e) {
            if (e.keyCode === 13 && !e.shiftKey) {
                e.preventDefault();
                $('#chat-submit-btn').click();
            }
        });

        $("textarea").each(function () {
            this.setAttribute("style", "height:" + (this.scrollHeight) + "px;overflow-y:hidden;");
        }).on("input", function () {
            this.style.height = 0;
            this.style.height = (this.scrollHeight) + "px";
        });

    }
}
