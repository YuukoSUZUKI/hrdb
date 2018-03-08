<template>
	<section>
		
		<!--一覧-->

		<template>
			<el-table :data="users" highlight-current-row v-loading="loading" style="width: 100%;"
				@row-click="handleRowSelect">

				<el-table-column type="index" width="60">
				</el-table-column>
				<el-table-column prop="employee.employee_number" label="社員番号" width="120" sortable>
				</el-table-column>
				<el-table-column prop="employee.name" label="社員名" width="120" sortable>
				</el-table-column>
				<el-table-column prop="employee.speciality" label="得意領域" >
				</el-table-column>

				<el-table-column label="" width="60">
					<template slot-scope="scope">
						<i class="el-icon-arrow-right"></i>
		      </template>
				</el-table-column>
			</el-table>
		</template>

	</section>
</template>
<script>
	import { getUserListTest } from '../../api/api';

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
				this.loading = true;

				getUserListTest(para).then(response => {
					console.log(response.status);
					console.log(response.data);
					this.users = response.data.users;
					this.loading = false;
				})
				.catch(error => {
					if (! error.response) {
						console.log('error: network error.')
					} else {
						console.log(error);
					}
					this.loading = false;
				})
			},
			//行選択
    	handleRowSelect(row, event, column) {
        console.log(column);
        this.$router.push({ path: '/employeeDetail', query: { id: row.employeeId }})
			},
		},
		
		mounted() {
			this.getUser();
		}
	};

</script>

<style scoped lang="scss">

