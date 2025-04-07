from flask import Blueprint, request, render_template, redirect, url_for

example_bp = Blueprint("example", __name__, url_prefix="/")

@example_bp.route("/process-data/", methods=['GET']) # GET 방식의 요청만 수신
def process_get_data():
    print("---------------->", request.method) # 현재 요청의 전송 방식 확인
    print("---------------->", request.args['message1'], request.args['message2']) # args : get 방식 요청 데이터 읽기
    return "receive get request"

@example_bp.route("/process-data/", methods=['POST']) # POST 방식의 요청만 수신
def process_post_data():
    print("---------------->", request.method) # 현재 요청의 전송 방식 확인
    print("---------------->", request.form['message1'], request.form['message2']) # form : post 방식 요청 데이터 읽기
    return "receive post request"

@example_bp.route("/path-variable/<data1>/")
def process_path_variable(data1):
    print("---------------->", data1)
    return "receive path variable"

@example_bp.route("/redirect/")
def process_redirect():
    # return redirect("/redirect-target")       # redirect 대상 경로를 직접 적용
    return redirect(url_for("example.redirect_target")) # redirect 대상 route 함수를 통해 경로 간접 적용

@example_bp.route("/redirect-target/")
def redirect_target():
    return "The end of redirect"

@example_bp.route("/template-syntax")
def template_syntax():
    # 1. 요청 데이터 읽기
    # 2. 요청 처리
    data1 = [54, 22, 16, 39, 61]
    data2 = { 'name': 'john doe', 'email': 'johndoe@example.com' }
    # 3. 응답 컨텐츠 만들기 --> template에게 요청 (사용할 html 파일과 전달할 데이터 지정)
    return render_template('my-template.html', dataa=data1, datab=data2)