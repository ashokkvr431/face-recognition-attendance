from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import auth, attendance

app = FastAPI(title="Face Attendance API")

# Allow frontend to connect
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Replace with your Flutter device IP for security
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Health check route
@app.get("/")
def home():
    return {"message": "Backend is running!"}

# Include routes
app.include_router(auth.router, prefix="/auth", tags=["Authentication"])
app.include_router(attendance.router, prefix="/attendance", tags=["Attendance"])
