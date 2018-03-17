<template>
	<section>

		<!--ツール類-->
		<el-col :span="24" class="toolbar" style="padding-bottom: 0px;">
			<el-form :inline="true" :model="filtersForm" ref="filtersForm">
				<!-- 検索ボックス(オートコンプリート) -->
				<el-form-item prop="SearchWordValues">
				  <el-select
				    v-model="filtersForm.SearchWordValues"
				    multiple
				    filterable
				    remote
				    placeholder="スキルで検索"
				    :remote-method="getCandidate"
				    :loading="isLoadingSearchWord"
				    class="keyword-box">
				    <el-option
				      v-for="item in SearchWordOptions"
				      :key="item.id"
				      :label="item.skill_name"
				      :value="item.id">
				    </el-option>
				  </el-select>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" icon="el-icon-search" v-on:click="getUser('',filtersForm.SearchWordValues)">検索</el-button>
				</el-form-item>
				<el-form-item>
					<el-button type="default" @click="dialogFormVisible = true" icon="el-icon-zoom-in" >詳細検索</el-button>
				</el-form-item>
				<el-form-item>
					<el-button type="default" @click="clearCondition" icon="el-icon-circle-close-outline" >条件クリア</el-button>
				</el-form-item>
			</el-form>
		</el-col>
		
		<!--一覧-->
		<template>
			<el-table :data="users" highlight-current-row v-loading="loading" style="width: 100%;"
				@row-click="handleRowSelect">

				<el-table-column type="index" width="60">
				</el-table-column>
				<el-table-column prop="employee_number" label="社員番号" width="120" sortable>
				</el-table-column>
				<el-table-column prop="name" label="社員名" width="120" sortable>
				</el-table-column>
				<el-table-column prop="speciality" label="得意領域" >
				</el-table-column>

				<el-table-column label="" width="60">
					<template slot-scope="scope">
						<i class="el-icon-arrow-right"></i>
		      </template>
				</el-table-column>
			</el-table>
		</template>


		<!-- 詳細検索ダイアログ -->
		<el-dialog title="スキル詳細検索" :visible.sync="dialogFormVisible" :center=true class="dialog-search" width="650px">
		  <el-form :model="detailform" ref="detailform" label-position="left">
		    <el-form-item label="氏名" prop="name" :label-width="formLabelWidth">
		      <el-input v-model="detailform.name" auto-complete="off" clearable></el-input>
		    </el-form-item>
		    <el-form-item prop="selectedSkills" label-width="0">
				  <el-checkbox-group v-model="detailform.selectedSkills" size="small" text-color="#FFF" fill="#409EFF">
			  	  <!-- スキルタグ -->
			  	  <el-collapse >
			        <el-collapse-item v-for="(skill_category,index) in dynamicCategories" 
			            :key="skill_category.id" :title="skill_category.skill_category_name" >
			          
			          <el-checkbox :key="skill.id" v-for="skill in skill_category.skills" :label="skill.id" :name="skill.skill_name" border>
			          {{skill.skill_name}}
			          </el-checkbox>
			          
			        </el-collapse-item>
			      </el-collapse>
			    </el-checkbox-group>
		    </el-form-item>

		  </el-form>
		  <span slot="footer" class="dialog-footer">
		    <el-button @click="dialogFormVisible = false">キャンセル</el-button>
		    <el-button type="primary" icon="el-icon-search" @click="detailedSearch">検索</el-button>
		  </span>
		</el-dialog>
		
		<!-- 個人詳細ダイアログ -->
		<employee-detail :dialogVisible.sync="dialogDetailVisible" :employee_id="selectedEmployeeId" ></employee-detail>

		

	</section>
</template>
<script>
	import { getUserListTest ,getSkillCategoryMap ,getSkillSearchList} from '../../api/api';
	//個人詳細
	import EmployeeDetailVue from './EmployeeDetail.vue'

	export default {
		data() {
			return {
			  //フリーワード検索
				filtersForm: {
					SearchWordValues: [],
				},
				SearchWordOptions:[],
				isLoadingSearchWord:false,
				//ユーザ一覧
				loading: false,
				users: [
				],
				
				//詳細検索ダイアログ
        dialogFormVisible: false,
        detailform: {
          name: '',
          //スキルチェックボックス
	        selectedSkills: [],
        },
        formLabelWidth: '120px',
        //アコーディオンとタグのデータ
        dynamicCategories: [],
				//個人詳細ダイアログ表示状態
				dialogDetailVisible: false ,
				selectedEmployeeId:'',
			};
		},
		created:function(){
			// スキルカテゴリ・スキル全取得
			getSkillCategoryMap().then(response => {
				console.log(response.status);
				console.log(response.data);
				this.dynamicCategories = response.data.skill_categories;
			})
			.catch(error => {
				if (! error.response) {
					console.log('error: network error.')
				} else {
					console.log(error);
				}
			})
		},
		methods: {
			//検索処理
			getUser: function (name,skills) {
				this.loading = true;

        let param = {name: name , skills: skills };
				getUserListTest(param).then(response => {
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

			//スキルオートコンプリート候補取得
  		getCandidate(query) {
	          this.isLoadingSearchWord = true;
	          
            // スキルカテゴリ・スキル全取得
            getSkillSearchList({skill_name:query}).then(response => {
            	console.log(response.status);
            	console.log(response.data);
            	this.SearchWordOptions = response.data.skills;
            	this.isLoadingSearchWord = false;
            })
            .catch(error => {
            	if (! error.response) {
            		console.log('error: network error.')
            	} else {
            		console.log(error);
            	}
            	this.isLoadingSearchWord = false;
            })
	    },
      
      //詳細検索
      detailedSearch(){
      	this.dialogFormVisible = false;
      	this.getUser(this.detailform.name, this.detailform.selectedSkills);
      },
      
      //検索条件クリア
      clearCondition(){
        //フリーワードフォーム
        this.$refs['filtersForm'].resetFields();
        
        //詳細検索ダイアログ表示前は undefined なので判定
        if ( this.$refs['detailform'] ) {
          this.$refs['detailform'].resetFields();
        }
      },
			
			//行選択
    	handleRowSelect(row, event, column) {
        console.log(column);
        console.log('現在選択しているのは'+row.employee_id);
        
        this.dialogDetailVisible = true ;
        this.selectedEmployeeId = row.employee_id ;
			},
		},
		
		mounted() {
			this.getUser('','');
		},
		// 個人詳細のコンポーネント登録(キャメルケースで登録する)
		components: {EmployeeDetail: EmployeeDetailVue},
	};



</script>

<style scoped lang="scss">

.keyword-box {
  width:300px;
}

.dialog-search {
	form {
		overflow-y : scroll;
		height :  350px;
	}
}
</style>
