from fastapi import FastAPI, HTTPException, Request, Depends
from pydantic import BaseModel
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session
from datetime import datetime
import asyncio
import os

# FastAPI application instance
app = FastAPI()

# Database setup
DATABASE_URL = "sqlite:///./commands.db"
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

class GPTMemory(Base):
    __tablename__ = "gpt_memory"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    summary = Column(String, nullable=False)
    session_id = Column(String, nullable=False)  # Add session_id column

# Dependency for database session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Create database tables
Base.metadata.create_all(bind=engine)

class CodeSnippet(BaseModel):
    code: str

class GPTMemoryRequest(BaseModel):
    title: str
    summary: str

@app.post("/run-shell/", response_model=dict)
async def run_shell_interactive(code_snippet: CodeSnippet):
    """Endpoint to execute Python shell code interactively."""
    try:
        # Define the shell_plus command
        command = (
            "bash -c 'source /home/lotfikan/blogv3/venv/bin/activate && "
            "python /home/lotfikan/blogv3/manage.py shell_plus'"
        )

        # Execute the command in an interactive shell
        process = await asyncio.create_subprocess_shell(
            command,
            stdin=asyncio.subprocess.PIPE,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
            cwd=os.getcwd(),  # Ensure the working directory is your project directory
        )

        # Send the code snippet to the shell and wait for output
        stdout, stderr = await asyncio.wait_for(
            process.communicate(input=code_snippet.code.encode()), timeout=30
        )

        # Check for errors
        if process.returncode != 0:
            raise HTTPException(status_code=500, detail=stderr.decode().strip())

        # Return the output
        return {"output": stdout.decode().strip()}

    except asyncio.TimeoutError:
        raise HTTPException(status_code=500, detail="Execution timed out.")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/gpt/memory", tags=["GPT Memory"])
async def commit_gpt_memory(request: GPTMemoryRequest, db: Session = Depends(get_db)):
    """
    Commit a summary of the GPT interactions to the memory table.
    """
    try:
        # Generate a unique session_id using the current UTC timestamp
        session_id = datetime.utcnow().strftime("%Y%m%d%H%M%S%f")

        # Create the memory entry with the generated session_id
        memory_entry = GPTMemory(
            title=request.title,
            summary=request.summary,
            session_id=session_id  # Use the generated session ID
        )
        db.add(memory_entry)
        db.commit()
        db.refresh(memory_entry)
        return {"message": "Memory committed successfully", "memory_id": memory_entry.id, "session_id": session_id}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error committing memory: {str(e)}")

@app.get("/gpt/memory", tags=["GPT Memory"])
async def refresh_gpt_memory(db: Session = Depends(get_db)):
    """
    Fetch all GPT memory entries in descending order by ID.
    """
    try:
        memories = db.query(GPTMemory).order_by(GPTMemory.id.desc()).all()
        return memories
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error fetching memory: {str(e)}")

@app.delete("/gpt/memory/{memory_id}", tags=["GPT Memory"])
async def delete_gpt_memory(memory_id: int, db: Session = Depends(get_db)):
    """
    Delete a specific memory entry by ID.
    """
    try:
        memory_entry = db.query(GPTMemory).filter(GPTMemory.id == memory_id).first()
        if not memory_entry:
            raise HTTPException(status_code=404, detail="Memory entry not found.")
        db.delete(memory_entry)
        db.commit()
        return {"message": "Memory entry deleted successfully."}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error deleting memory: {str(e)}")

@app.get("/run-health-check", response_model=dict)
async def run_health_check():
    """
    Endpoint to check the server's health and readiness.
    """
    return {"status": "Healthy", "timestamp": datetime.utcnow().isoformat()}
