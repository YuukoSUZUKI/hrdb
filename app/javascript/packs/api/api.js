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

export const getUserList = params => { return axios.get(`${base}/user/list`, { params: params }); };

export const getUserListTest = params => { return client.get(`${base}/api/user/list`, { params: params }); }; 
export const getSkillCategoryMap = params => {return client.get(`${base}/api/skill_categories`);};
export const getEmployee = params => {return client.get(`${base}/api/employee`, { params: params }); }; 

export const getUserListPage = params => { return axios.get(`${base}/user/listpage`, { params: params }); };

export const removeUser = params => { return axios.get(`${base}/user/remove`, { params: params }); };

export const batchRemoveUser = params => { return axios.get(`${base}/user/batchremove`, { params: params }); };

export const editUser = params => { return axios.get(`${base}/user/edit`, { params: params }); };

export const addUser = params => { return axios.get(`${base}/user/add`, { params: params }); };