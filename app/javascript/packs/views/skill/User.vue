<template>
	<section>

		<!--ツール類-->
		<el-col :span="24" class="toolbar" style="padding-bottom: 0px;">
			<el-form :inline="true" :model="filters">
				<!-- 検索ボックス(オートコンプリート) -->
				<el-form-item>
					<el-autocomplete
				      class="inline-input"
				      v-model="filters.name"
				      :fetch-suggestions="querySearch"
				      placeholder="社員名"
				      @select="handleSelect"
				    >
					</el-autocomplete>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" icon="el-icon-search" v-on:click="getUser(filters.name,'')">検索</el-button>
				</el-form-item>
				<el-form-item>
					<el-button type="default" @click="dialogFormVisible = true" >詳細な条件で検索</el-button>
				</el-form-item>
			</el-form>
		</el-col>
		
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


		<!-- 詳細検索ダイアログ -->
		<el-dialog title="スキル詳細検索" :visible.sync="dialogFormVisible" :center=true custom-class="dialog-search">
		  <el-form :model="detailform" label-position="left">
		    <el-form-item label="氏名" :label-width="formLabelWidth">
		      <el-input v-model="detailform.name" auto-complete="off"></el-input>
		    </el-form-item>
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

		  </el-form>
		  <span slot="footer" class="dialog-footer">
		    <el-button @click="dialogFormVisible = false">キャンセル</el-button>
		    <el-button type="primary" icon="el-icon-search" @click="detailedSearch">検索</el-button>
		  </span>
		</el-dialog>

	</section>
</template>
<script>
	import { getUserListTest ,getSkillCategoryMap} from '../../api/api';

	export default {
		data() {
			return {
				filters: {
					name: ''
				},
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
        /*
	      dynamicCategories: [ {id:'1',catName:'言語', inputVisible:false ,inputValue:'' ,items:['java','C#','PHP','VB']},
	                              {id:'2', catName:'フレームワーク', inputVisible:false ,inputValue:'' , items:['spring','struts2','cakePHP','.net','iBatis','dbflute']},
	                              {id:'3', catName:'OS・DB・ミドルウェア', inputVisible:false ,inputValue:'' ,items:['Linux','Oracle','MySQL','postgresql','Apache','Tomcat','redis','memcached']},
	                              {id:'4', catName:'業種', inputVisible:false ,inputValue:'' ,items:['人材紹介','保険代理店','小売','流通','不動産']},
	                              {id:'5', catName:'ポジション', inputVisible:false ,inputValue:'' ,items:['PM','サブリーダー']},
	                              {id:'6', catName:'フェーズ', inputVisible:false ,inputValue:'' ,items:['要件定義','基本設計(外部設計)','詳細設計(内部設計)','結合テスト','総合テスト']},
	                              {id:'7', catName:'資格', inputVisible:false ,inputValue:'' ,items:['PMP','ITIL','Oracle Gold']},
	                            ],
				*/
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
				this.loading = false;
			})
		},
		methods: {
			//検索処理
			getUser: function (name, skills) {
				let para = {
					name: name,
					skills: skills
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

			//オートコンプリート関連
			querySearch(queryString, cb) {
        var links = this.links;
        var results = queryString ? links.filter(this.createFilter(queryString)) : links;
        // call callback function to return suggestions
        cb(results);
      },
      createFilter(queryString) {
        return (link) => {
          return (link.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
        };
      },
      loadAll() {
        return [
         ];
      },
      handleSelect(item) {
        console.log(item);
      },
			// /オートコンプリート関連
      
      //詳細検索
      detailedSearch(){
      	this.dialogFormVisible = false;
      	this.getUser(this.detailform.name, this.detailform.selectedSkills);
      },
			
			//行選択
    	handleRowSelect(row, event, column) {
        console.log(column);
        console.log('現在選択しているのは'+row.employee.id);
        this.$router.push({ path: '/employeeDetail', query: { id: row.employeeId }})
        //this.$router.push({ path: '/sandbox', params: {id: row.employee.id}})
			},
		},
		
		mounted() {
			this.getUser('','');
			//オートコンプリート
      this.links = this.loadAll();
		}
	};

</script>

<style scoped lang="scss">

.dialog-search {
	form {
		overflow-y : scroll;
		height :  350px;
	}
}


</style>
