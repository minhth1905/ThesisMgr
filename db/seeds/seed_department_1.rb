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


departments_2 = Department.new(name: "Khoa Điện tử viễn thông", office: "Văn phòng 201E3")
departments_2.save
id2 = departments_2.id
Subject.create(name: "Bộ môn Hệ thống viễn thông", department_id: id2)
Subject.create(name: "Bộ môn Thông tin vô tuyến", department_id: id2)
Subject.create(name: "Bộ môn Điện tử và Kỹ thuật máy tính", department_id: id2)
Subject.create(name: "Bộ môn Vi cơ điện tử và Vi cơ hệ thống", department_id: id2)

Lab.create(name: "Phòng Thí nghiệm Tín hiệu và Hệ thống", department_id: id2)
Lab.create(name: "Phòng thực hành Điện tử Viễn thông", department_id: id2)
