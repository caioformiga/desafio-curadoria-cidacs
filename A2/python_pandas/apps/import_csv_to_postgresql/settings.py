from logging import error
import os


from os.path import join, dirname, exists, join

# pip install python-dotenv
from dotenv import load_dotenv

# percore do arquivo atual até chegar na pasta PY_PANDAS_PATH
# diretório atual = dirname(__file__)
levels = 2
current_folder = dirname(__file__)
for i in range(levels): 
    # usa o modulo os.path
    current_folder = dirname(current_folder) 

if (current_folder.find('python_pandas') != -1):
    # HOME_CIDACS/python_pandas
    PY_PANDAS_PATH = current_folder
else:
    error(r'Problemas para localizar a pasta raiz!')
    exit(1)

# carrega o arquivo .env que está localizado na raiz do projeto 
dotenv_file_path = join(PY_PANDAS_PATH,'config/.env_censo_escolar')
load_dotenv(dotenv_file_path)
print(f'Foram carregadas as configurações de: {dotenv_file_path}')

# sempre que o sufixo for PATH deve ser um caminho completo
# sempre que o sufixo for NAME deve ser apenas uma string sem '/'

# HOME_CIDACS/python_pandas/data
DATA_PATH = join(PY_PANDAS_PATH, 'data')
# HOME_CIDACS/python_pandas/dictionary
DICTIONARY_PATH = join(PY_PANDAS_PATH, 'dictionary')
# HOME_CIDACS/python_pandas/apps
APPS_PATH = join(PY_PANDAS_PATH, 'apps')

CENSO_APP_NAME = os.environ.get('CENSO_APP_NAME')
# HOME_CIDACS/python_pandas/data/censo_escolar
CENSO_APP_DATA_PATH = join(DATA_PATH, CENSO_APP_NAME.lower())
# HOME_CIDACS/python_pandas/dictionary/censo_escolar
CENSO_APP_DICTIONARY_PATH = join(DICTIONARY_PATH, CENSO_APP_NAME.lower())

# HOME_CIDACS/python_pandas/apps/censo_escolar
CENSO_APP_PATH = join(APPS_PATH, CENSO_APP_NAME.lower())

CENSO_DICTIONARY_PATH = os.environ.get('CENSO_DICTIONARY_PATH')
CENSO_DATA_PATH = os.environ.get('CENSO_DATA_PATH')

CONTEXT_DOCENTES = os.environ.get('CONTEXT_DOCENTES')
CONTEXT_ESCOLAS = os.environ.get('CONTEXT_ESCOLAS')
CONTEXT_TURMAS = os.environ.get('CONTEXT_TURMAS')

SOURCE_FILE_DICTIONARY = os.environ.get('SOURCE_FILE_DICTIONARY')
SOURCE_FILE_DOCENTES = os.environ.get('SOURCE_FILE_DOCENTES')
SOURCE_FILE_ESCOLAS = os.environ.get('SOURCE_FILE_ESCOLAS')
SOURCE_FILE_TURMAS = os.environ.get('SOURCE_FILE_TURMAS')
