from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)


# Configure the SQLAlchemy database URI
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql://p3:Mtmqn584@34.136.218.122:3306/p3_courses"


# Create a SQLAlchemy instance
db = SQLAlchemy(app)


# Define a simple database model (optional)
class Course(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))


@app.route('/')
def home():
    return render_template('home.html')


@app.route('/page1')
def page1():
    return render_template('page1.html')


@app.route('/page2')
def page2():
    return render_template('page2.html')


@app.route('/page3')
def page3():
    return render_template('page3.html')


if __name__ == '__