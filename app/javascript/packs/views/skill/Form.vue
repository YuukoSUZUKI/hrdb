<template>
	<el-form ref="form" :model="form" label-width="80px" @submit.prevent="onSubmit" style="margin:20px;width:60%;min-width:600px;">
		<el-form-item label="氏名">
			<el-input v-model="form.name"></el-input>
		</el-form-item>
		<el-form-item label="性別">
			<el-radio-group v-model="form.sex">
				<el-radio label="男性"></el-radio>
				<el-radio label="女性"></el-radio>
				<el-radio label="不明"></el-radio>
			</el-radio-group>
		</el-form-item>
		<el-form-item label="得意領域">
			<el-input
			  type="textarea"
			  :autosize="{ minRows: 2, maxRows: 4}"
			  placeholder="Please input"
			  v-model="form.specialty">
			</el-input>
		</el-form-item>
		<el-form-item>
			<el-button type="primary">更新</el-button>
			<el-button @click.native.prevent>キャンセル</el-button>
		</el-form-item>
	</el-form>
</template>

<script>
	export default {
		data() {
			return {
				form: {
					name: '',
					sex: '',
					specialty: ''
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