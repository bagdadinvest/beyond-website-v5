document.addEventListener("DOMContentLoaded", function () {
    const container = document.getElementById("chat-widget-container");

    // Create Shadow DOM
    const shadowRoot = container.attachShadow({ mode: "open" });

    // Add HTML, CSS, and JS for the chatbot widget
    shadowRoot.innerHTML = `
    <style>
    /* Import Materialize CSS */
    @import url('https://fonts.googleapis.com/icon?family=Material+Icons');
    @import url('{% static 'bot/css/materialize.min.css' %}');
    @import url('{% static 'bot/css/style.css' %}');

    /* Scoped CSS for Shadow DOM */
    .container {
        font-family: 'Roboto', sans-serif;
    }
    </style>

    <div class="container">
    <div id="modal1" class="modal">
    <canvas id="modal-chart"></canvas>
    </div>

    <div class="widget">
    <div class="chat_header">
    <span class="chat_header_title">Sara</span>
    <span class="dropdown-trigger" href="#" data-target="dropdown1">
    <i class="material-icons"> more_vert </i>
    </span>
    <ul id="dropdown1" class="dropdown-content">
    <li><a href="#" id="clear">Clear</a></li>
    <li><a href="#" id="restart">Restart</a></li>
    <li><a href="#" id="close">Close</a></li>
    </ul>
    </div>
    <div class="chats" id="chats">
    <div class="clearfix"></div>
    </div>
    <div class="keypad">
    <textarea
    id="userInput"
    placeholder="Type a message..."
    class="usrInput"
    ></textarea>
    <div id="sendButton">
    <i class="fa fa-paper-plane" aria-hidden="true"></i>
    </div>
    </div>
    </div>
    <div class="profile_div" id="profile_div">
    <img class="imgProfile" src="{% static 'bot/img/botAvatar.png' %}" />
    </div>
    <div class="tap-target" data-target="profile_div">
    <div class="tap-target-content">
    <h5 class="white-text">Hey there 👋</h5>
    <p class="white-text">
    I can help you get started with Rasa and answer your technical questions.
    </p>
    </div>
    </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="{% static 'bot/js/lib/materialize.min.js' %}"></script>
    <script src="{% static 'bot/js/lib/uuid.min.js' %}"></script>
    <script src="{% static 'bot/js/lib/chart.min.js' %}"></script>
    <script src="{% static 'bot/js/lib/showdown.min.js' %}"></script>
    <script src="{% static 'bot/js/script.js' %}"></script>
    `;
});
