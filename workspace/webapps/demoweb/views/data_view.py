from flask import Blueprint
from flask import render_template, redirect
from flask import request

import os
from pathlib import Path

data_bp = Blueprint('data', __name__, url_prefix="/data")

@data_bp.route('/titanic', methods=['GET'])
def titanic():
    # 파일에서 데이터 읽기
    bp_path = data_bp.root_path # 현재 blueprint의 경로
    root_path = Path(bp_path).parent #  부모 경로 
    file_path = os.path.join(root_path, 'data_files', 'titanic_train.csv')
    # 템플릿으로 이동 ( 위에서 읽은 데이터 전달 )
    pass