<template>
	<section>
		
		<!--一覧-->

		<template>
			<el-table :data="users" highlight-current-row v-loading="loading" style="width: 100%;"
				>

				<el-table-column type="index" width="60">
				</el-table-column>
		<!--
				<el-table-column prop="id" label="ユーザID" width="120" sortable>
				</el-table-column>
		-->
				<el-table-column prop="authority" label="権限" width="120" sortable>
				</el-table-column>

			</el-table>
		</template>

	</section>
</template>
<script>
	import { getUserListTest } from '../../api/api';
	import axios from 'axios';
	export const client = axios.create({
    baseURL: 'http://localhost:8080',
    timeout: 5000,
    withCredentials:true,
    headers: {
      'Accept': 'application/json',
    	'Content-Type': 'application/json',
  	}
	});

	export default {
		data() {
			return {
				loading: false,
				users: [
				]
			};
		},
		methods: {
			//検索処理
			getUser: function () {
				let para = {
					name: ''
				};
				//this.loading = true;

				//getUserListTest(para).then((res) => {
				//getUserListTest().then((res) => {
				//	this.users = res.data.users;
				//	//this.loading = false;

				//});
				
				//client.get('http://localhost:8080/api/users').then(response => {
				client.get('https://7d1272605f7345139ac0184324cf33fa.vfs.cloud9.us-east-1.amazonaws.com/api/users').then(response => {
					console.log(response.status);
					console.log(response.data);
					this.users = response.data.users;
					
				})
				.catch(error => {
					if (! error.response) {
						console.log('error: network error.')
					} else {
						console.log(error);
					}
				})

				
			},
		},
		
		mounted() {
			this.getUser();
		}
	};

</script>

<style scoped lang="scss">

