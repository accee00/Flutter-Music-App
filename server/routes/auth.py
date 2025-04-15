import uuid
import bcrypt
from fastapi import Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models.user import User
from pydantic_schema.user_create import UserCreate
from fastapi import APIRouter

from pydantic_schema.user_login import UserLogin

router=APIRouter()

@router.post('/signup',status_code=201)
def signup_user(user:UserCreate,db:Session=Depends(get_db)): 
    # check if user already exists in db
    # Run query on User table and check if passed mail is present in User table or not.
    user_db= db.query(User).filter(User.email==user.email).first()
    if user_db:
         raise HTTPException(400,"User with same email already exists!.")
    
    # encrypt password
    hashed_pw=bcrypt.hashpw(password=user.password.encode(),salt=bcrypt.gensalt())
    # add the user to the db
    user_db = User(id=str(uuid.uuid4()),email=user.email,password=hashed_pw,name=user.name)
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    return user_db 

@router.post('/signin')
def login_user(user:UserLogin,db:Session=Depends(get_db)):
     # check if user with same email exists. 
     user_db=db.query(User).filter(User.email==user.email).first()

     if not user_db:
          raise HTTPException(400,"User with this email does not exists!.")
     
     # pasword matching or not. 
     is_match= bcrypt.checkpw(password=user.password.encode(),hashed_password=user_db.password)
     if not is_match:
          raise HTTPException(400,"Incorrect password.")
     return user_db