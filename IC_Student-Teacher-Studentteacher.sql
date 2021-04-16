--select * from dbo.Teacher
--select * from StudentTeacher
--select * from dbo.Student

select * from Teacher t
full join StudentTeacher st on t.TeacherID=st.TeacherID
full join Student s on st.StudentID=s.StudentID


--1. Get all students name & phone number whereby their teacher is Justin.

select s.StudentName,s.Telephone from Teacher t
full join StudentTeacher st on t.TeacherID=st.TeacherID
full join Student s on st.StudentID=s.StudentID
where t.TeacherName ='Justin'


--2. Get all students name & phone number provided they have at least one teacher.
select s.StudentName,s.Telephone from Teacher t
full join StudentTeacher st on t.TeacherID=st.TeacherID
full join Student s on st.StudentID=s.StudentID
where st.TeacherID is not Null


--3. Get all teacher name provided they have at least one student.
select t.TeacherName from Teacher t
full join StudentTeacher st on t.TeacherID=st.TeacherID
full join Student s on st.StudentID=s.StudentID
where st.StudentID is not null

--4. List down all teachers regardless he/she have a student or not.
select * from Teacher t
full join StudentTeacher st on t.TeacherID=st.TeacherID
full join Student s on st.StudentID=s.StudentID
where t.TeacherName is not null

select t.TeacherName from Teacher t
left join StudentTeacher st on t.TeacherID=st.TeacherID


--5. List down all students regardlesshe/she have a teacher or not.

select s.StudentName from Student s
left join StudentTeacher st on s.StudentID=st.StudentID


--6. List down all teachers and students regardless the teacher has a student or not.
select t.TeacherName, s.StudentName from Teacher t
left join StudentTeacher st on t.TeacherID=st.TeacherID
 left join Student s on s.StudentID=st.StudentID




--7. List down all students and teacher regardless the student has a teacher or not
select t.TeacherName, s.StudentName from Teacher t
right join StudentTeacher st on t.TeacherID=st.TeacherID
 right join Student s on s.StudentID=st.StudentID




