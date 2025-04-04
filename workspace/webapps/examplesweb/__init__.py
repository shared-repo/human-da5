from flask import Flask, render_template

def create_app(): # Flask framework와 약속된 이름의 함수 (역할 : application 생성)

    app = Flask(__name__)

    @app.route("/")
    def index():
        # return "hello flask"
        return render_template("index.html") # templates/index.html을 찾아서 처리한 후 응답

    return app