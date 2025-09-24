from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter()

# Example user model
class User(BaseModel):
    username: str
    password: str

# Mock database (replace with real DB later)
users_db = {}

@router.post("/register")
def register(user: User):
    if user.username in users_db:
        return {"error": "User already exists"}
    users_db[user.username] = user.password
    return {"message": "User registered successfully"}

@router.post("/login")
def login(user: User):
    if user.username not in users_db or users_db[user.username] != user.password:
        return {"error": "Invalid credentials"}
    return {"message": f"Welcome back {user.username}"}
