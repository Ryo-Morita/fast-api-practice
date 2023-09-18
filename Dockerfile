# python3.11
FROM python:3.11-buster
# python出力表示のDocker用に調整
ENV PYTHONUNBUFFERED=1

WORKDIR /src

# pipでpoetryをinstall
RUN pip install poetry

# poetryの定義ファイルをコピー
COPY project.toml* poerty.lock* ./

# poetryでインストール(pyproject.tomlが既にある場合)
RUN poetry config virtualenvs.in-project true
RUN if [ -f pyproject.toml ]; then poetry install --no-root; fi

# uvicornサーバー立ち上げ
ENTRYPOINT [ "poetry", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--reload" ]