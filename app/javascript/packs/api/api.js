import axios from 'axios';

let base = '';

  // モックではなく本番用
	export const client = axios.create({
    timeout: 5000,
    withCredentials:true,
    headers: {
      'Accept': 'application/json',
    	'Content-Type': 'application/json',
  	}
	});

export const requestLogin = params => { return axios.post(`${base}/login`, params).then(res => res.data); };

//スキル キーワード検索候補リスト
export const getSkillSearchList = params => { return client.get(`${base}/api/skill/list`, { params: params }); };

export const getUserList = params => { return axios.get(`${base}/user/list`, { params: params }); };

export const getUserListTest = params => { return client.get(`${base}/api/user/list`, { params: params }); }; 
export const getSkillCategoryMap = params => {return client.get(`${base}/api/skill_categories`);};
export const getEmployee = employee_id => {return client.get(`${base}/api/employees/` + employee_id); }; 
export const editEmployee = employee_id => {return client.get(`${base}/api/employees/` + employee_id + `/edit`); };
export const createSkill = skill => {return client.post(`${base}/api/skills`, skill); };
export const updateEmployee = employee => {return client.patch(`${base}/api/employees/` + employee.id, employee); }; 

// export const getUserListPage = params => { return axios.get(`${base}/user/listpage`, { params: params }); };
export const getUserManageList = params => { return client.get(`${base}/api/users`, { params: params }); };

//ユーザ管理＞ユーザ一覧
export const getUser = user_id => {return client.get(`${base}/api/users/` + user_id); }; 

export const removeUser = params => { return axios.get(`${base}/user/remove`, { params: params }); };

export const batchRemoveUser = params => { return axios.get(`${base}/user/batchremove`, { params: params }); };

//ユーザ編集
export const editUser = user => { return client.patch(`${base}/api/users/`+ user.id , user); };
// export const editUser = params => { return axios.get(`${base}/user/edit`, { params: params }); };
//ユーザ新規登録
export const addUser = user => { return client.post(`${base}/api/users`, user); };
// export const addUser = params => { return axios.get(`${base}/user/add`, { params: params }); };