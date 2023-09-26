import time


class Course:
    def __init__(self, id, name, lecturer):
        self.id = id
        self.name = name
        self.created = time.time()
        self.lecturer = lecturer
        self.syllabus = []
        self.participants = []

    def update_syllabus(self):
        pass

    def remove_student(self, name):
        pass

    def cancel_course(self):
        pass

    def register(self, name):
        self.participants.append(name)



class SummerCourse(Course):
    def __init__(self, id, name, lecturer, duration):
        super().__init__(id, name, lecturer)
        self.duration = duration

    def process_payment(self, amount):
        pass

    def register(self, name):
        super().register(name)
        raise RuntimeError('Registration is not allowed in summer courses')






c1 = SummerCourse('123', 'Algebra', 'John', '1w')
c1.register('dfdf')


# alg_course = Course('123', 'Algebra', 'John')
# alg_course.register('David')
# alg_course.register('Alon')

print()
