import Mock from 'mockjs';
const LoginUsers = [
  {
    id: 1,
    username: 'admin',
    password: '123456',
    avatar: 'https://raw.githubusercontent.com/taylorchen709/markdown-images/master/vueadmin/user.png',
    name: '人財太郎'
  }
];

const Users = [];

for (let i = 0; i < 86; i++) {
  Users.push(Mock.mock({
    id: Mock.Random.guid(),
    employeeId: Mock.Random.integer(1,9999),
    employee_number: Mock.Random.integer(1,9999),
    name: Mock.Random.name(),
    addr: Mock.mock('@county(true)'),
    'age|18-60': 1,
    birth: Mock.Random.date(),
    sex: Mock.Random.integer(0, 1),
    username:Mock.Random.name(),
    authority:Mock.Random.integer(1,2),
    speciality: Mock.mock('@sentence'),
  }));
}

export { LoginUsers, Users };
