from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

DATABASE_URL= 'postgresql://postgres:test123@localhost:5432/musicapp'
# Create a new SQLAlchemy engine instance using the database URL
# This engine manages the connection pool and handles communication with the database
engine = create_engine(DATABASE_URL)

# Create a session factory bound to the engine
# autocommit=False: ensures that you explicitly commit transactions
# autoflush=False: disables automatic flushing of changes to the database (can be manually triggered)
# bind=engine: connects the session to the database via the engine
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
def get_db():
     db=SessionLocal()
     try:
          yield db
     finally:
          db.close()