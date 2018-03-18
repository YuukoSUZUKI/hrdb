<template>
	<section>
		<!--検索エリア-->
		<el-col :span="24" class="toolbar" style="padding-bottom: 0px;">
			<el-form :inline="true" :model="filters">
				<el-form-item>
					<el-input v-model="filters.name" placeholder="氏名"></el-input>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" v-on:click="getUsers">検索</el-button>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" @click="handleAdd">新規登録</el-button>
				</el-form-item>
			</el-form>
		</el-col>

		<!--検索結果-->
		<el-table :data="users" highlight-current-row v-loading="listLoading" style="width: 100%;">
			<el-table-column type="index" width="60">
			</el-table-column>
			<el-table-column prop="employee.employee_number" label="社員番号" width="120" sortable>
			</el-table-column>
			<el-table-column prop="employee.name" label="氏名" width="120" sortable>
			</el-table-column>
			<el-table-column prop="authority" label="権限" width="100" :formatter="formatAuthority" sortable>
			</el-table-column>
			
			<el-table-column label="操作" width="150">
				<template scope="scope">
					<el-button size="small" @click="handleEdit(scope.$index, scope.row)">編集</el-button>
					<!--<el-button type="danger" size="small" @click="handleDel(scope.$index, scope.row)">削除</el-button>-->
				</template>
			</el-table-column>
			
		</el-table>

		<!--フッター-->
		<!--
		<el-col :span="24" class="toolbar">
			<el-pagination layout="prev, pager, next" @current-change="handleCurrentChange" :page-size="20" :total="total" style="float:right;">
			</el-pagination>
		</el-col>
		-->

		<!--編集エリア-->
		<el-dialog title="編集" :visible.sync="editFormVisible" :close-on-click-modal="false">
			<el-form :model="editForm" label-width="120px" :rules="editFormRules" ref="editForm" v-loading="editLoading">
				<el-form-item label="氏名" prop="name">
					<el-input v-model="editForm.name" auto-complete="off"></el-input>
				</el-form-item>
				<el-form-item label="社員番号" prop="employee_number">
					<el-input v-model.number="editForm.employee_number" auto-complete="off"></el-input>
				</el-form-item>
				<el-form-item label="アカウント" prop="account">
					<el-input v-model="editForm.account" auto-complete="off"></el-input>
				</el-form-item>
				<el-form-item label="パスワード" prop="password">
					<el-input v-model="editForm.password" auto-complete="off"></el-input>
				</el-form-item>
				<el-form-item label="権限">
					<el-radio-group v-model="editForm.authority">
						<el-radio class="radio" :label="2">一般</el-radio>
						<el-radio class="radio" :label="1">マネージャー</el-radio>
					</el-radio-group>
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click.native="editFormVisible = false">取消</el-button>
				<el-button type="primary" @click.native="editSubmit">更新</el-button>
			</div>
		</el-dialog>

		<!--新規登録エリア-->
		<el-dialog title="新規登録" :visible.sync="addFormVisible" :center=true :close-on-click-modal="false">
			<el-form :model="addForm" label-width="80px" :rules="addFormRules" ref="addForm">
				<el-form-item label="氏名" prop="name">
					<el-input v-model="addForm.name" auto-complete="off"></el-input>
				</el-form-item>
				<el-form-item label="権限">
					<el-radio-group v-model="addForm.authority">
						<el-radio class="radio" :label="2">一般</el-radio>
						<el-radio class="radio" :label="1">マネージャー</el-radio>
					</el-radio-group>
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click.native="addFormVisible = false">取消</el-button>
				<el-button type="primary" @click.native="addSubmit" :loading="addLoading">更新</el-button>
			</div>
		</el-dialog>
		
	</section>
</template>

<script>
	import util from '../../common/js/util'
	//import NProgress from 'nprogress'
	import { getUserManageList,getUser, removeUser,editUser, addUser } from '../../api/api';
	export default {
		data() {
			return {
				filters: {
					name: ''
				},
				users: [],
				total: 0,
				page: 1,
				listLoading: false,
				editFormVisible: false,//編集エリア表示/非表示
				editLoading: false,
				//編集フォームのバリデーションルール
				editFormRules: {
					name: [
						{ required: true, trigger: 'blur',whitespace:true , message: '必ず入力してください'}
					],
					employee_number: [
						{ type:'number',min:1, max: 9999, trigger: 'blur' ,message: '半角数字4桁以内で入力してください',  }
					],
					account: [
						{ required: true, trigger: 'blur' ,whitespace:true ,message: '必ず入力してください'},
						{ pattern:/^[a-zA-Z0-9!-/:-@¥[-`{-~]+$/ ,trigger: 'blur' ,message: '半角英数記号で入力してください'},
					],
					password: [
						{ required: true, trigger: 'blur' ,whitespace:true ,message: '必ず入力してください'},
						{ pattern:/^[a-zA-Z0-9!-/:-@¥[-`{-~]+$/ ,trigger: 'blur' ,message: '半角英数記号で入力してください'},
					],
				},
				//編集エリア
				editForm: {
					id: null,
					name: '',
					employee_number: '',
					account: '',
					password: '',
					authority: -1,
					employee_id:null,
				},
				addFormVisible: false,//新規エリア表示/非表示
				addLoading: false,
				addFormRules: {
					name: [
						{ required: true, message: '氏名を入れてください', trigger: 'blur' }
					]
				},
				//新規エリア
				addForm: {
					name: '',
					authority: -1,
					password:''
				}
			}
		},
		methods: {
			//権限変換
			formatAuthority: function (row, column) {
				return row.authority == 2 ? '一般' : row.authority == 1 ? 'マネージャー' : '不明';
			},
			handleCurrentChange(val) {
				this.page = val;
				this.getUsers();
			},
			//一覧取得
			getUsers() {
				let para = {
					page: this.page,
					name: this.filters.name
				};
				this.listLoading = true;
				//NProgress.start();
				getUserManageList(para).then((res) => {
					//this.total = res.data.total;
					this.users = res.data.users;
					this.listLoading = false;
					//NProgress.done();
				});
			},
			//削除
			handleDel: function (index, row) {
				this.$confirm('本当に削除しますか？', '確認', {
					type: 'warning'
				}).then(() => {
					this.listLoading = true;
					//NProgress.start();
					let para = { id: row.id };
					removeUser(para).then((res) => {
						this.listLoading = false;
						//NProgress.done();
						this.$message({
							message: '削除成功',
							type: 'success'
						});
						this.getUsers();
					});
				}).catch(() => {
				});
			},
			//編集画面を表示する
			handleEdit: function (index, row) {
				this.editFormVisible = true;
				this.editLoading = true;

        let vueInstance = this ;
				getUser(row.id).then((res) => {
					//ユーザ情報をフォームに表示
					let user = res.data.user;
					vueInstance.editForm.id = user.id ;
					vueInstance.editForm.name = user.employee.name;
					vueInstance.editForm.employee_number = user.employee.employee_number;
					vueInstance.editForm.account = user.account;
					vueInstance.editForm.authority = user.authority;
					vueInstance.editForm.employee_id = user.employee.id;
					//NProgress.done();
					this.editLoading = false;
				});
				
			},
			//追加画面を表示する
			handleAdd: function () {
				console.log('handleAdd')
				this.editForm = {
					id: null,
					name: '',
					employee_number: '',
					account: '',
					password: '',
					authority: -1,
					employee_id:null,
					
				}
				this.editFormVisible = true;

				// this.addFormVisible = true;
				// this.addForm = {
				// 	name: '',
				// 	authority: -1,
				// 	password: ''
				// };
			},
			//編集送信
			editSubmit: function () {
				this.$refs.editForm.validate((valid) => {
					if (valid) {
						this.$confirm('更新しますか？', '確認', {}).then(() => {
							this.editLoading = true;
							
									//更新する
					      	let para = {
					      		id : this.editForm.id,
					      		account : this.editForm.account,
					      		authority: this.editForm.authority,
					      		//employeeテーブルをaccepts_nested_attributes_forで更新するので入れ子の形
					      		employee_attributes: {id:this.editForm.employee_id ,
					      														name: this.editForm.name,
					      														employee_number: this.editForm.employee_number,
					      													}
					      	};
					      	//パスワードは入力があった場合のみ送信する
					      	if (this.editForm.password) {
					      		para.password = this.editForm.password;
					      	}
					      	
					      	editUser(para).then(response => {
											console.log(response.data);
											this.editLoading = false;
											this.$message.success('社員情報を更新しました。');
											
											//フォームを閉じる
											this.editFormVisible = false;
											//一覧を再取得
											this.getUsers();
										})
										.catch(error => {
											this.$message.error('エラーが発生しました。');
											if (! error.response) {
												console.log('error: network error.')
											} else {
												console.log(error);
											}
											this.editLoading = false;
										});

						})
						.catch(_ => {});

					}
				});
			},
			//新規追加
			addSubmit: function () {
				this.$refs.addForm.validate((valid) => {
					if (valid) {
						this.$confirm('登録しますか？', '確認', {}).then(() => {
							this.addLoading = true;
							//NProgress.start();
							let para = Object.assign({}, this.addForm);
							addUser(para).then((res) => {
								this.addLoading = false;
								//NProgress.done();
								this.$message({
									message: '登録成功',
									type: 'success'
								});
								this.$refs['addForm'].resetFields();
								this.addFormVisible = false;
								this.getUsers();
							});
						});
					}
				});
			},
		},
		mounted() {
			this.getUsers();
		}
	}
</script>

<style scoped>
</style>