from flask import Blueprint
from flask import render_template, redirect
from flask import request

import os
from pathlib import Path

import pandas as pd

data_bp = Blueprint('data', __name__, url_prefix="/data")

@data_bp.route('/titanic', methods=['GET'])
def titanic():
    # 파일에서 데이터 읽기
    bp_path = data_bp.root_path # 현재 blueprint의 경로 ( 여기서는 views )
    root_path = Path(bp_path).parent #  부모 경로 (여기서는 demoweb )
    file_path = os.path.join(root_path, 'data_files', 'titanic-train.csv')
    df_titanic = pd.read_csv(file_path)

    # 템플릿으로 이동 ( 위에서 읽은 데이터 전달 )
    return render_template('data/titanic.html', df=df_titanic)