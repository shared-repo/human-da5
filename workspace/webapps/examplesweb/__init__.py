from flask import Flask, render_template, request

def create_app(): # Flask framework와 약속된 이름의 함수 (역할 : application 생성)

    app = Flask(__name__)

    @app.route("/")
    def index():
        # return "hello flask"
        return render_template("index.html") # templates/index.html을 찾아서 처리한 후 응답
    
    @app.route("/process-data/", methods=['GET']) # GET 방식의 요청만 수신
    def process_get_data():
        print("---------------->", request.method) # 현재 요청의 전송 방식 확인
        print("---------------->", request.args['message1'], request.args['message2']) # args : get 방식 요청 데이터 읽기
        return "receive get request"
    
    @app.route("/process-data/", methods=['POST']) # POST 방식의 요청만 수신
    def process_post_data():
        print("---------------->", request.method) # 현재 요청의 전송 방식 확인
        print("---------------->", request.form['message1'], request.form['message2']) # form : post 방식 요청 데이터 읽기
        return "receive post request"
    
    @app.route("/path-variable/<data1>/")
    def process_path_variable(data1):
        print("---------------->", data1)
        return "receive path variable"

    return app