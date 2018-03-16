<template>
	<el-form ref="employee" :model="employee" label-width="80px" v-loading="loading" @submit.prevent="onSubmit" style="margin:20px;width:60%;min-width:600px;">
		<el-form-item label="社員番号">
			{{employee.employee_number}}
		</el-form-item>
		<el-form-item label="社員名">
			{{employee.name}}
		</el-form-item>
		<el-form-item label="得意領域">
			<el-input
			  type="textarea"
			  :autosize="{ minRows: 2, maxRows: 4}"
			  placeholder="得意とする領域、特殊な経験を記載ください。"
			  v-model="employee.speciality">
			</el-input>
		</el-form-item>
		<el-form-item label="特記事項">
			<el-input
			  type="textarea"
			  :autosize="{ minRows: 2, maxRows: 4}"
			  placeholder="メモ欄です。ご自由にお使いください。"
			  v-model="employee.memo">
			</el-input>
		</el-form-item>
		
		<!-- el-from-item にしていないのは、使うとname プロパティでスクリプトエラーが出る(collapseとの相性か) -->
	  <el-checkbox-group v-model="employee.selectedSkills" size="small" text-color="#FFF" fill="#409EFF">
  	  <!-- スキルタグ -->
  	  <el-collapse v-model="activeNames">
        <el-collapse-item v-for="(skill_category,key,index) in dynamicCategories" 
            :key="skill_category.id" :name="skill_category.id" :title="skill_category.skill_category_name">
          
          <el-checkbox :key="skill.id" v-for="skill in skill_category.skills" :label="skill.id" :name="skill.skill_name"  border>
          	{{skill.skill_name}}
          </el-checkbox>

          <el-input
            class="input-new-tag"
            v-show="skill_category.input_visible"
            v-model="skill_category.inputValue"
            ref="saveTagInput"
            size="mini"
            placeholder="スキル名を入力"
            @keyup.enter.native="handleInputConfirm(skill_category)"
            @blur="handleInputConfirm(skill_category)"
          >
          </el-input>
          <el-button v-show="skill_category.input_visible === false" class="button-new-tag" size="small" @click="showInput(skill_category)">+ 追加</el-button>        
  
        </el-collapse-item>
      </el-collapse>
    </el-checkbox-group>
			
		<el-form-item>
			<el-button type="primary" @click="handleUpdate">更新</el-button>
			<el-button @click.native.prevent>キャンセル</el-button>
		</el-form-item>
	</el-form>
</template>

<script>
	import { getSkillCategoryMap, createSkill, getEmployee, updateEmployee} from '../../api/api';
	
	export default {
		props: ['id' ],
		data() {
			return {
				loading: false,
				employee: {
					employee_number: '',
					name:'',
					specialty: '',
					memo:'',
	        //TODO カテゴリ毎にする必要があるかも？
	        //スキルの選択状態
	        selectedSkills: [],
				},
				//アコーディオンとタグのデータ
				dynamicCategories: [],
	      //アコーディオン展開
	      activeNames: [],
			}
		},
		mounted:function(){
			this.loading = true;
			var current = this;
			// スキルカテゴリ・スキル全取得
			getSkillCategoryMap().then(response => {
				console.log(response.status);
				console.log(response.data);
				
				let cat = response.data.skill_categories;
				cat.forEach(function(category) {
					category.input_visible = false;
					category.inputValue = '';
				});
				this.dynamicCategories = cat;

				this.dynamicCategories.forEach(function(category){
				current.activeNames.push(category.id);
				});
			})
			.catch(error => {
				if (! error.response) {
					console.log('error: network error.')
				} else {
					console.log(error);
				}

			});
			this.load();
			
			this.loading = false;			
		},
		methods: {
			onSubmit() {
				console.log('submit!');
			},
			load(){
				var current = this;
				getEmployee(1).then(response => {
				  //APIの結果を画面にセット
					this.employee.name = response.data.name;
					this.employee.employee_number = response.data.employee_number;
					this.employee.speciality = response.data.speciality;
					this.employee.memo = response.data.memo;
					//スキル階層
					response.data.skill_categories.forEach(function(category) {
						//console.log(category);
						category.skills.forEach(function(skill) {
							//console.log(skill);
							current.employee.selectedSkills.push(skill.id);
						});
					});
				})
				.catch(error => {
					if (! error.response) {
						console.log('error: network error.')
					} else {
						console.log(error);
					}
				});
			},

      //タグ追加のテキストボックス表示
      showInput(category) {
        //表示フラグを立てる
        category.input_visible = true;
        //テキストボックスが表示されるまでタイムラグがあるので nextTickに表示後の処理
        this.$nextTick(_ => {
          //対象のテキストボックスにフォーカスを当てる
          let index = this.dynamicCategories.indexOf(category) ;
          let input = this.$refs.saveTagInput[index];
          input.focus();
        });
      },
      //タグ新規追加
			handleInputConfirm(category) {
				let inputValue = category.inputValue;
				//テキスト未入力の場合は、追加しない
				if (inputValue ) {
					let para = {skill_category_id: category.id,
											skill_name: inputValue
					};
					createSkill(para).then(response => {
						console.log(response.data);
						if (response.status === 422) {
							this.$message.error('入力されたスキルはリストにあります。リストから選択ください。');
						}
						else {
							category.skills.push(response.data.skill);
						}
					})
					.catch(error => {
						if (! error.response) {
							console.log('error: network error.')
						} else {
							console.log(error);
						}
						this.loading = false;
					});
        	
        }
        category.input_visible = false;
        category.inputValue = '';
      } ,
      // 社員情報更新
      handleUpdate(){
      	let para = {
      		id : 1,
      		speciality: this.employee.speciality,
      		memo: this.employee.memo,
      		skill_ids : this.employee.selectedSkills
      	};
      	updateEmployee(para).then(response => {
						console.log(response.data);
						this.$message('社員情報を更新しました。');
					})
					.catch(error => {
						if (! error.response) {
							console.log('error: network error.')
						} else {
							console.log(error);
						}
					});
      },
			
			
		}
	}

</script>