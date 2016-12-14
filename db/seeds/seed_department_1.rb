departments = Department.new(name: "Khoa Công nghệ thông tin", office: "Văn phòng 401E3")
departments.save
id = departments.id
Subject.create(name: "Bộ môn công nghệ phần mềm", department_id: id)
Subject.create(name: "Bộ môn hệ thống thông tin", department_id: id)
Subject.create(name: "Bộ môn Truyền thông và mạng máy tính", department_id: id)
Subject.create(name: "Bộ môn Khoa học và kỹ thuật tính toán", department_id: id)
Subject.create(name: "Bộ môn Vật lý kĩ thuật", department_id: id)

Lab.create(name: "Phòng thí nghiệm tương tác người máy", department_id: id)
Lab.create(name: "Phòng thí nghiệm An toàn thông tin", department_id: id)
Lab.create(name: "Phòng thí nghiệm Hệ thống nhúng", department_id: id)
Lab.create(name: "Phòng thí nghiệm Công nghệ tri thức", department_id: id)
Lab.create(name: "Phòng thí nghiệm Truyền thông mạng máy tính", department_id: id)

