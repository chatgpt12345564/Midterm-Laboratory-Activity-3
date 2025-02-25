from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mysqldb import MySQL

app = Flask(__name__)
app.secret_key = 'your_secret_key'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'school_db'

mysql = MySQL(app)

from MySQLdb.cursors import DictCursor

@app.route('/teachers')
def teachers():
    cur = mysql.connection.cursor(DictCursor) 
    cur.execute("SELECT * FROM teachers")
    teachers = cur.fetchall()
    cur.close()
    print("Fetched Teachers:", teachers)  
    return render_template('teachers.html', teachers=teachers)


@app.route('/add_teacher', methods=['GET', 'POST'])
def add_teacher():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO teachers (name, email) VALUES (%s, %s)", (name, email))
        mysql.connection.commit()
        cur.close()
        flash('Teacher added successfully!', 'success')
        return redirect(url_for('teachers'))
    return render_template('add_teacher.html')

@app.route('/edit_teacher/<int:id>', methods=['GET', 'POST'])
def edit_teacher(id):
    cur = mysql.connection.cursor(DictCursor)
    cur.execute("SELECT * FROM teachers WHERE id = %s", (id,))
    teacher = cur.fetchone()
    cur.close()
    
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        cur = mysql.connection.cursor()
        cur.execute("UPDATE teachers SET name = %s, email = %s WHERE id = %s", (name, email, id))
        mysql.connection.commit()
        cur.close()
        flash('Teacher updated successfully!', 'success')
        return redirect(url_for('teachers'))
    return render_template('edit_teacher.html', teacher=teacher)


@app.route('/delete_teacher/<int:id>')
def delete_teacher(id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM teachers WHERE id = %s", (id,))
    mysql.connection.commit()
    cur.close()
    flash('Teacher deleted successfully!', 'success')
    return redirect(url_for('teachers'))

@app.route('/students')
def students():
    cur = mysql.connection.cursor(DictCursor)
    cur.execute("SELECT students.id, students.name, students.email, teachers.name AS teacher_name FROM students JOIN teachers ON students.teacher_id = teachers.id")
    students = cur.fetchall()
    cur.close()
    return render_template('students.html', students=students)


@app.route('/add_student', methods=['GET', 'POST'])
def add_student():
    cur = mysql.connection.cursor(DictCursor)
    cur.execute("SELECT id, name FROM teachers")
    teachers = cur.fetchall()
    cur.close()

    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        teacher_id = request.form.get('teacher_id')

        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO students (name, email, teacher_id) VALUES (%s, %s, %s)", (name, email, teacher_id))
        mysql.connection.commit()
        cur.close()

        flash('Student added successfully!', 'success')
        return redirect(url_for('students'))
    return render_template('add_student.html', teachers=teachers)

@app.route('/edit_student/<int:id>', methods=['GET', 'POST'])
def edit_student(id):
    cur = mysql.connection.cursor(DictCursor)
    cur.execute("SELECT * FROM students WHERE id = %s", (id,))
    student = cur.fetchone()
    cur.execute("SELECT * FROM teachers")
    teachers = cur.fetchall()
    cur.close()
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        teacher_id = request.form['teacher_id']
        
        cur = mysql.connection.cursor()
        cur.execute("UPDATE students SET name = %s, email = %s, teacher_id = %s WHERE id = %s",
                    (name, email, teacher_id, id))
        mysql.connection.commit()
        cur.close()
        
        flash('Student updated successfully!', 'success')
        return redirect(url_for('students'))
    
    return render_template('edit_student.html', student=student, teachers=teachers)


@app.route('/delete_student/<int:id>')
def delete_student(id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM students WHERE id = %s", (id,))
    mysql.connection.commit()
    cur.close()
    flash('Student deleted successfully!', 'success')
    return redirect(url_for('students'))

if __name__ == '__main__':
    app.run(debug=True)
