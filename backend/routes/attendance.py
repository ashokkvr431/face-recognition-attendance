from fastapi import APIRouter
from pydantic import BaseModel
from typing import List

router = APIRouter()

class Attendance(BaseModel):
    username: str
    status: str  # "present" or "absent"

attendance_db: List[dict] = []

@router.post("/mark")
def mark_attendance(record: Attendance):
    attendance_db.append(record.dict())
    return {"message": f"Attendance marked for {record.username}"}

@router.get("/list")
def get_attendance():
    return {"attendance": attendance_db}
