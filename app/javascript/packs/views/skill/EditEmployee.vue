<template>
	<el-form ref="employee" :model="employee" label-width="80px" @submit.prevent="onSubmit" style="margin:20px;width:60%;min-width:600px;">
		<el-form-item label="社員番号">
			<el-input v-model="employee.employee_number" placeholder="4桁数値"></el-input>
		</el-form-item>
		<el-form-item label="得意領域">
			<el-input
			  type="textarea"
			  :autosize="{ minRows: 2, maxRows: 4}"
			  placeholder="得意とする領域、特殊な経験を記載ください。"
			  v-model="employee.specialty">
			</el-input>
		</el-form-item>
		<el-form-item label="特記事項">
			<el-input
			  type="textarea"
			  :autosize="{ minRows: 2, maxRows: 4}"
			  placeholder="メモ欄"
			  v-model="employee.memo">
			</el-input>
		</el-form-item>
		<el-form-item>
			<el-button type="primary">更新</el-button>
			<el-button @click.native.prevent>キャンセル</el-button>
		</el-form-item>
	</el-form>
</template>

<script>
 import axios from 'axios';
	export default {
		data() {
			return {
				employee: {
					employee_number: '',
					specialty: '',
					memo:''
				}
			}
		},
		methods: {
			onSubmit() {
				console.log('submit!');
			}
		}
	}

</script>