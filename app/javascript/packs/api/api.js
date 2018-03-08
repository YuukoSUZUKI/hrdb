import axios from 'axios';

let base = '';

  // モックではなく本番用
	export const client = axios.create({
    baseURL: 'https://7d1272605f7345139ac0184324cf33fa.vfs.cloud9.us-east-1.amazonaws.com',
    timeout: 5000,
    withCredentials:true,
    headers: {
      'Accept': 'application/json',
    	'Content-Type': 'application/json',
  	}
	});

export const requestLogin = params => { return axios.post(`${base}/login`, params).then(res => res.data); };

export const getUserList = params => { return axios.get(`${base}/user/list`, { params: params }); };

export const getUserListTest = params => { return client.get(`/api/users`); }; //お砂場用

export const getUserListPage = params => { return axios.get(`${base}/user/listpage`, { params: params }); };
//export const getUserListPage = params => {return axios.get(`${base}/api/users`, {params: params}); };

export const removeUser = params => { return axios.get(`${base}/user/remove`, { params: params }); };

export const batchRemoveUser = params => { return axios.get(`${base}/user/batchremove`, { params: params }); };

export const editUser = params => { return axios.get(`${base}/user/edit`, { params: params }); };

export const addUser = params => { return axios.get(`${base}/user/add`, { params: params }); };