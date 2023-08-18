from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import uvicorn

app = FastAPI()

if __name__ == '__main__':
    uvicorn.run('app:main:app', host='127.0.0.1', port=8000, reload=True)
