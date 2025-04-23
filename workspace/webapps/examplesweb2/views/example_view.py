from flask import Blueprint, request, render_template, redirect, url_for, jsonify

from openai import OpenAI

example_bp = Blueprint("example", __name__, url_prefix="/")

# 환경변수 OPENAI_API_KEY="key"가 설정된 후 사용 가능 : windows 에서는 set OPENAI_API_KEY=... 실행
client = OpenAI()

@example_bp.route("/process-data/", methods=['GET']) # GET 방식의 요청만 수신
def process_get_data():
    print("---------------->", request.method) # 현재 요청의 전송 방식 확인
    print("---------------->", request.args['message1'], request.args['message2']) # args : get 방식 요청 데이터 읽기
    # print("---------------->", request.args['message3']) # 요청에 포함되지 않은 데이터를 읽으면 오류
    print("---------------->", request.args.get('message3', 'not available')) # 없으면 'not available' 사용
    return "receive get request"

@example_bp.route("/process-data/", methods=['POST']) # POST 방식의 요청만 수신
def process_post_data():
    print("---------------->", request.method) # 현재 요청의 전송 방식 확인
    print("---------------->", request.form['message1'], request.form['message2']) # form : post 방식 요청 데이터 읽기
    # print("---------------->", request.form['message3']) # 요청에 포함되지 않은 데이터를 읽으면 오류
    print("---------------->", request.form.get('message3', 'not available')) # 없으면 'not available' 사용
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

@example_bp.route("/template-syntax/")
def template_syntax():
    # 1. 요청 데이터 읽기
    # 2. 요청 처리
    data1 = [54, 22, 16, 39, 61]
    data2 = { 'name': 'john doe', 'email': 'johndoe@example.com' }
    # 3. 응답 컨텐츠 만들기 --> template에게 요청 (사용할 html 파일과 전달할 데이터 지정)
    return render_template('my-template.html', dataa=data1, datab=data2)

@example_bp.route("/static-files/")
def use_static_files():
    return render_template("show-static-files.html")

# -----------------------------------------------------------

@example_bp.route("/chatbot/")
def chatbot():
    return render_template('chatbot.html')

@example_bp.route('/chatbot/chat-text/', methods=['POST'])
def chat_text():
    json_data = request.get_json()
    message = json_data.get('message')

    completion = client.chat.completions.create(
        model="chatgpt-4o-latest",
        messages=[
            { "role": "system", "content": "당신은 모든 정보를 잘 알고 있는 친절한 안내자입니다. 질문에 대해 가능한 간결하게 답변해야 합니다." },
            { "role": "user", "content": message }
        ],
        n=1,
        temperature=1
    )
    
    return jsonify({ 'message' : completion.choices[0].message.content })
